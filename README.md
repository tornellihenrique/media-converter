# **Media Converter with Context Menu Integration**

A Python tool that lets you convert or compress images, audio, and video files directly from the Windows File Explorer context menu. Just right-click a supported file, select the desired action, and the process runs instantly.

Convert your media files directly from the context menu:

![Context Menu Image](images/context_menu_image.png)

![Context Menu Audio](images/context_menu_audio.png)

![Context Menu Compress Video](images/context_menu_compress_video.png)

The CMD window provides real-time feedback during video/audio conversions:

![Context Menu Video](images/context_menu_video.png)

## **Features**

- **Seamless Integration**: Integrates into the Windows 10/11 context menu for quick access.
- **Image Conversion**: Convert images to JPEG or PNG formats.
- **Audio Conversion**: Convert audio files to MP3 or WAV formats.
- **Video Conversion**: Convert videos to MP4 or AVI formats.
- **Video Compression**: Compress any MP4 or AVI videos.
- **Silent Operation**: Executes conversions without cluttering your screen with command windows.
- **Logging**: Detailed logs are stored in the user's home directory for auditing and debugging.
- **Easy Setup and Removal**: Simple batch scripts to install and uninstall the context menu entries.

## **Prerequisites**

- **Python 3.6 or higher**: Ensure Python is installed and added to your system `PATH`.
- **`pip` Package Manager**: Comes with Python installations.
- **`ffmpeg`**: Download and install from [ffmpeg.org](https://ffmpeg.org/), and add it to your system `PATH`.

## **Installation**

1. **Clone the Repository:**

   ```bash
   git clone https://github.com/tornellihenrique/media-converter.git
   ```

2. **Navigate to the Project Directory:**

   ```bash
   cd media-converteer
   ```

3. **Install Dependencies:**

   ```bash
   pip install -r requirements.txt
   ```

   **Note**: If you encounter permissions issues, you may need to run the command as an administrator or use a virtual environment.

4. **Install `ffmpeg`:**

   - Download from [ffmpeg.org](https://ffmpeg.org/download.html).
   - Add the `ffmpeg/bin` folder to your system `PATH`.

5. **Set Up Context Menu Integration:**

   - Right-click on `setup_registry.bat` and select **Run as administrator**.
   - Confirm any prompts to allow the script to modify the registry.

## **Usage**

### **Converting Files**

1. **Right-Click on a Media File**: Supported file types are listed below.
2. **Select an Option**:
   - For images: **Convert Image > Convert to JPEG/PNG**.
   - For audio: **Convert Audio > Convert to MP3/WAV**.
   - For convert video: **Convert Video > Convert to MP4/AVI**.
   - For compress video: **Compress Video**.
3. **Wait for Processing**:
   - A CMD window will appear showing the progress.
   - After completion, press any key to exit the CMD window.
4. **Find Your Output File**:
   - The output file will be in the same directory as the original file.

### **Supported File Types**

- **Images**: `.jpg`, `.jpeg`, `.png`, `.bmp`, `.tiff`
- **Audio**: `.mp3`, `.wav`, `.ogg`, `.flac`, `.aac`
- **Video**: `.mp4`, `.avi`, `.mkv`, `.mov`

### **Logs**

- Conversion logs are stored in `convert_media.log` and `compress_video.log` in your home directory (`C:\Users\YourUsername\...`).

## **Project Structure**

```
media-converter/
│
├── convert_media.py           # Python script for handling conversions
├── compress_video.py          # Python script for handling compressions
├── requirements.txt           # Python dependencies
├── setup_registry.bat         # Batch script to add registry entries
├── remove_registry.bat        # Batch script to remove registry entries
├── README.md                  # Project documentation
└── LICENSE                    # License file
```

## **Contributing**

Contributions are welcome! Please open an issue or submit a pull request for any improvements.

## **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## **Acknowledgments**

- **[Pillow](https://python-pillow.org/)**: For image processing.
- **[FFmpeg](https://ffmpeg.org/)**: For audio and video conversions.