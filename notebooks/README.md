# DeepStream 8.0 Jupyter Notebook

## 📓 Notebook: `DeepStream_Test.ipynb`

This is a **clean, properly structured** DeepStream 8.0 object detection pipeline notebook.

### ✅ What's Fixed

The previous `Untitled.ipynb` had multiple critical issues:
1. ❌ `Gst.init()` was commented out → **Fixed**: Now properly initialized
2. ❌ Cells ran in wrong order → **Fixed**: Proper sequential flow
3. ❌ Elements created without initialization → **Fixed**: Correct order
4. ❌ Missing proper event loop → **Fixed**: GLib.MainLoop with bus handler
5. ❌ Incomplete cleanup causing corrupted videos → **Fixed**: Proper pipeline shutdown

### 🎯 How to Use

**Run cells in order (top to bottom):**

1. **Cell 1**: Import libraries and initialize GStreamer
2. **Cell 2**: Set configuration (paths, class IDs)
3. **Cell 3**: Define helper function
4. **Cell 4**: Create pipeline and all elements
5. **Cell 5**: Configure element properties
6. **Cell 6**: Build and link pipeline
7. **Cell 7**: Define metadata probe function
8. **Cell 8**: Attach probe to OSD
9. **Cell 9**: Setup bus message handler
10. **Cell 10**: **Run the pipeline** (this processes the video)
11. **Cell 11**: Check output file
12. **Cell 12**: Display video in Jupyter

### 📹 Pipeline Flow

```
filesrc (input video)
  ↓
h264parse
  ↓
nvv4l2decoder (GPU-accelerated decoding)
  ↓
nvstreammux (batching)
  ↓
nvinfer (object detection with TensorRT)
  ↓
nvvideoconvert
  ↓
nvdsosd (on-screen display - draws boxes and text)
  ↓
queue
  ↓
nvvideoconvert
  ↓
nvv4l2h264enc (GPU-accelerated H.264 encoding)
  ↓
qtmux (MP4 container)
  ↓
filesink (output video)
```

### 🎬 What It Does

- **Reads** an H.264 video file (`sample_720p.h264`)
- **Detects** vehicles, persons, bicycles, and road signs
- **Draws** bounding boxes around detected objects
- **Displays** frame statistics (frame number, object counts)
- **Encodes** the annotated video to MP4 format
- **Saves** output to `/app/notebooks/ds_out.mp4`

### 🔍 Output

After running the pipeline, you'll see:
- Console output showing frame-by-frame detection counts
- Performance statistics (processing time)
- Output video file with bounding boxes and labels

### 💡 Tips

1. **Always run cells in order** - each cell depends on previous ones
2. **Don't skip the first cell** - `Gst.init()` is required
3. **Wait for Cell 10 to complete** - this is where the actual processing happens
4. **Check Cell 11** before playing video - ensures file was created successfully

### 🐛 Troubleshooting

**Problem**: Pipeline fails to start
- **Solution**: Make sure Cell 1 was executed (`Gst.init()` must be called)

**Problem**: Video is blank/corrupted
- **Solution**: The new notebook has proper cleanup - this should not happen anymore

**Problem**: Can't find output file
- **Solution**: Check Cell 11 - it shows the exact location and file size

**Problem**: "Element not created" errors
- **Solution**: You're inside the DeepStream Docker container, right? Run the notebook from Jupyter Lab inside the container.

### 🚀 Quick Start

From your host machine:
```bash
cd ~/deepstream8
./start_jupyter.sh
```

Then open `http://localhost:8888` and navigate to `DeepStream_Test.ipynb`

### 📊 Expected Results

- **Input**: 720p H.264 video (sample traffic scene)
- **Processing time**: ~40-60 seconds (depends on GPU)
- **Output**: MP4 video with detected objects and labels
- **Detections**: Vehicles, persons, bicycles in each frame

---

**Note**: This notebook demonstrates the DeepStream Python bindings (pyds) working correctly with DeepStream SDK 8.0.



