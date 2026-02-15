# DeepStream 8.0 with Python Bindings

Ready-to-use Docker image with NVIDIA DeepStream 8.0, Python bindings (pyds), and Jupyter Lab.

## Quick Start

```bash
docker pull manasi1096/deepstream8-python:latest

docker run --rm -it \
    --runtime=nvidia \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -p 8888:8888 \
    manasi1096/deepstream8-python:latest
```

Then open: **http://localhost:8888**

## Included Notebooks

| Notebook | Description |
|----------|-------------|
| `object_detection.ipynb` | Basic object detection pipeline with traffic detection model |
| `object_detection_multistream.ipynb` | Process multiple video streams simultaneously |
| `object_detection_and_tracking_classification.ipynb` | Detection + tracking + secondary classification |
| `queue_sizing.ipynb` | **Queue length monitoring** with PeopleNet model, ROI-based counting, and smart filtering |


## Prerequisites

- Docker
- NVIDIA Driver 570.124.06+
- CUDA 12.8
- NVIDIA Container Toolkit (`nvidia-docker2`)

## What's Included

- **DeepStream 8.0** with Triton support
- **Python bindings (pyds)** compiled from source
- **Jupyter Lab** for interactive development
- **Sample videos** from DeepStream SDK
- **Pre-trained models** (traffic detection, PeopleNet)

## Build From Source

```bash
git clone https://github.com/Manasi-NV/Deepstream8-pythonbindings.git
cd Deepstream8-pythonbindings
docker build -t deepstream8-python .
```

## Mount Your Own Videos

```bash
docker run --rm -it \
    --runtime=nvidia \
    -e NVIDIA_VISIBLE_DEVICES=all \
    -p 8888:8888 \
    -v /path/to/your/videos:/app/videos \
    manasi1096/deepstream8-python:latest
```

## Pipeline Architecture

```
filesrc → h264parse → nvv4l2decoder → nvstreammux → nvinfer → 
nvvideoconvert → nvdsosd → nvvideoconvert → capsfilter → 
nvv4l2h264enc → h264parse → mp4mux → filesink
```

## License

Apache 2.0
