import os
import sys
import logging
from pathlib import Path
import subprocess

# Configure logging
log_file = Path.home() / "compress_video.log"
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(log_file, mode='a', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

def compress_video(input_file, compression_level):
    """
    Compress the input video at one of three levels:
      'small'  -> CRF=18  (higher quality, bigger file)
      'medium' -> CRF=23  (default trade-off between size and quality)
      'high'   -> CRF=28  (lower quality, smaller file)
    """
    logging.info(f"Starting video compression: {input_file}, level: {compression_level}")
    base_name, extension = os.path.splitext(input_file)
    extension = extension.lower()

    # Supported formats: .mp4 and .avi
    if extension not in [".mp4", ".avi"]:
        logging.error(f"Unsupported video format: {extension}. Only .mp4 and .avi are supported.")
        return

    # Determine CRF based on compression level
    if compression_level == "small":
        crf_value = "18"  # Higher quality, larger file
    elif compression_level == "medium":
        crf_value = "23"  # Default
    elif compression_level == "high":
        crf_value = "28"  # Lower quality, smaller file
    else:
        logging.error(f"Invalid compression level: {compression_level}.")
        return

    # Build the output file path
    output_file = f"{base_name}(compress){extension}"
    logging.info(f"Output file will be: {output_file}")

    # FFmpeg command pattern
    # Original example:
    #   ffmpeg -i "%i" -crf 23 -preset medium -movflags +faststart -c:a aac "%output.mp4"
    # We adapt the CRF value based on compression_level.
    command = [
        "ffmpeg", "-y",
        "-i", input_file,
        "-crf", crf_value,
        "-preset", "medium",
        "-movflags", "+faststart",
        "-c:a", "aac",
        output_file
    ]
    logging.info(f"Running command: {' '.join(command)}")

    try:
        process = subprocess.Popen(
            command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True
        )
        for line in process.stdout:
            if sys.stdout:
                sys.stdout.write(line)
            logging.debug(line.strip())
        process.stdout.close()
        process.wait()

        if process.returncode == 0:
            logging.info(f"Video compressed successfully: {output_file}")
        else:
            logging.error(f"FFmpeg failed with return code {process.returncode}.")
    except Exception as e:
        logging.error(f"Error during video compression: {e}", exc_info=True)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        logging.error("Usage: compress_video.py <file_path> <compression_level>")
        logging.error("compression_level must be one of: small, medium, high")
        sys.exit(1)

    file_path = sys.argv[1]
    compression_level = sys.argv[2]

    if not os.path.exists(file_path):
        logging.error(f"File not found: {file_path}")
        sys.exit(1)

    compress_video(file_path, compression_level)

    # Pause the script if running in a console to allow the user to view the output
    if sys.stdin and sys.stdout:
        input("Press any key to exit...")
