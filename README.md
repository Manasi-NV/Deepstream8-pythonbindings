# DeepStream 8.0 with Python Bindings

## Prerequisites

- Docker
- NVIDIA Driver Version - 570.124.06
- CUDA Version - 12.8

## Build Instructions

```bash
docker build -t deepstream-jupyter .
```

Build time: ~10-15 minutes (compiles Python bindings from source)

## Run Instructions

### Using the startup script:

```bash
./start_jupyter.sh
```

### Or manually:

```bash
docker run -it --rm \
    --runtime=nvidia \
    -e NVIDIA_VISIBLE_DEVICES=all \
    --net=host \
    -v $(pwd)/notebooks:/app/notebooks \
    deepstream-jupyter \
    jupyter lab --ip=0.0.0.0 --port=9901 --no-browser --allow-root --notebook-dir=/app/notebooks --NotebookApp.token='' --NotebookApp.password=''
```

Access Jupyter Lab at: **http://localhost:9901**

## What's Included

- **DeepStream 8.0** with Triton support (base: `nvcr.io/nvidia/deepstream:8.0-triton-multiarch`)
- **Python bindings (pyds)** built from source
- **Jupyter Lab** for interactive development
- **Common data science libraries**: 
  - numpy
  - pandas
  - matplotlib
  - scikit-learn
  - opencv-python

