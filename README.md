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

### Queue Sizing Features
- **PeopleNet model** for accurate person detection
- **Overlap-based counting** (30% threshold) - more accurate than center-point
- **Background filtering** - excludes small/distant people
- **Cashier zone exclusion** - prevents counting staff behind counter
- **Configurable ROI** - define your queue area

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

## Models

✅ **PeopleNet model is already included** in this repository - no download required!

The TensorRT engine (`.engine`) will be auto-generated on first run for your specific GPU.

### Download Newer Version (Optional)

If you want to update to a newer version of PeopleNet:

### Option 1: Download from NGC (Recommended)

```bash
# Install NGC CLI
pip install ngc-cli

# Login to NGC (get API key from https://ngc.nvidia.com/setup/api-key)
ngc config set

# Download PeopleNet model
ngc registry model download-version nvidia/tao/peoplenet:pruned_quantized_decrypted_v2.6.3
```

### Option 2: Direct Download

Download from [NVIDIA NGC PeopleNet](https://catalog.ngc.nvidia.com/orgs/nvidia/teams/tao/models/peoplenet):
- `resnet34_peoplenet_int8.onnx` - ONNX model file
- `resnet34_peoplenet_int8.txt` - INT8 calibration file
- `labels.txt` - Class labels (person, bag, face)

Place files in: `notebooks/models/peoplenet/`

### Model Configuration

The PeopleNet config file (`pgie_peoplenet_config.txt`) is pre-configured with:
- Input resolution: 960x544
- Classes: Person (0), Bag (1), Face (2)
- INT8 precision for optimal performance

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
