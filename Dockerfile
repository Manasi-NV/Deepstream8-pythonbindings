# Start from the NVIDIA DeepStream base image you are using
FROM nvcr.io/nvidia/deepstream:8.0-triton-multiarch

# Set a working directory inside the container
WORKDIR /app

# Copy the Python requirements file into the container's working directory
COPY requirements.txt .

# Update package lists and install pip, then install the Python libraries
RUN apt-get update && \
    apt-get install -y python3-pip python3-dev python3-gi python3-gst-1.0 \
    python-gi-dev git cmake g++ build-essential \
    libglib2.0-dev libgstreamer1.0-dev libgirepository1.0-dev libcairo2-dev \
    pybind11-dev && \
    pip install --no-cache-dir -r requirements.txt && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Clone and build DeepStream Python bindings for DS 8.0
# Following official instructions from https://github.com/NVIDIA-AI-IOT/deepstream_python_apps/blob/master/bindings/README.md
# Need to initialize git submodules to get pybind11
RUN cd /opt/nvidia/deepstream/deepstream-8.0/sources && \
    git clone https://github.com/NVIDIA-AI-IOT/deepstream_python_apps.git && \
    cd deepstream_python_apps && \
    git submodule update --init && \
    cd bindings && \
    mkdir build && cd build && \
    cmake .. && \
    make -j$(nproc) && \
    cp pyds.so /usr/local/lib/python3.12/dist-packages/

# Set PYTHONPATH to include the apps directory with common modules
ENV PYTHONPATH="${PYTHONPATH}:/opt/nvidia/deepstream/deepstream-8.0/sources/deepstream_python_apps/apps"

# The command to run when the container starts is a bash shell
CMD ["/bin/bash"]