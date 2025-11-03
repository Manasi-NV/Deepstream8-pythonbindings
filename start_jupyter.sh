#!/bin/bash
# Script to start DeepStream 8.0 container with Jupyter Lab

echo "=========================================="
echo "Starting DeepStream 8.0 + Jupyter Lab"
echo "=========================================="
echo ""
echo " Jupyter Lab will be available at: http://localhost:8888"
echo ""

# Run the container with GPU support and notebook mounting
# --NotebookApp.token='' disables authentication
docker run -it --rm \
    --runtime=nvidia \
    -e NVIDIA_VISIBLE_DEVICES=all \
    --net=host \
    -v $(pwd)/notebooks:/app/notebooks \
    deepstream-jupyter \
    jupyter lab --ip=0.0.0.0 --port=9901 --no-browser --allow-root --notebook-dir=/app/notebooks --NotebookApp.token='' --NotebookApp.password=''

echo ""
echo "Jupyter Lab stopped."

