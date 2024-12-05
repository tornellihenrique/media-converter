import os
import sys
import logging
from pathlib import Path
from PIL import Image
import subprocess

# Configure logging
log_file = Path.home() / "convert_media.log"
logging.basicConfig(
    level=logging.DEBUG,
    format="%(asctime)s - %(levelname)s - %(message)s",
    handlers=[
        logging.FileHandler(log_file, mode='a', encoding='utf-8'),
        logging.StreamHandler(sys.stdout)
    ]
)

def convert_image(input_file, output_extension):
    try:
        logging.info(f"Starting image conversion: {input_file} -> {output_extension}")
        img = Image.open(input_file)
        base_name, _ = os.path.splitext(input_file)
        output_file = f"{base_name}.{output_extension}"
        img.save(output_file)
        logging.info(f"Image converted successfully: {output_file}")
    except Exception as e:
        logging.error(f"Error during image conversion: {e}", exc_info=True)

def convert_media(input_file, output_extension):
    try:
        logging.info(f"Starting media conversion: {input_file} -> {output_extension}")
        base_name, _ = os.path.splitext(input_file)
        output_file = f"{base_name}.{output_extension}"
        
        # FFmpeg command
        command = [
            "ffmpeg", "-i", input_file, output_file
        ]
        logging.info(f"Running command: {' '.join(command)}")

        # Run FFmpeg and stream the output to the console
        process = subprocess.Popen(
            command, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, universal_newlines=True
        )
        for line in process.stdout:
            sys.stdout.write(line)  # Display output in the CMD window
            logging.debug(line.strip())  # Log output to the file
        process.stdout.close()
        process.wait()

        if process.returncode == 0:
            logging.info(f"Media converted successfully: {output_file}")
        else:
            logging.error(f"FFmpeg failed with return code {process.returncode}.")
    except Exception as e:
        logging.error(f"Error during media conversion: {e}", exc_info=True)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        logging.error("Invalid arguments. Usage: convert_media.py <file_path> <output_extension>")
        sys.exit(1)
    
    file_path = sys.argv[1]
    output_extension = sys.argv[2]

    if not os.path.exists(file_path):
        logging.error(f"File not found: {file_path}")
        sys.exit(1)

    _, file_extension = os.path.splitext(file_path)
    file_extension = file_extension.lower()

    if file_extension in [".png", ".jpg", ".jpeg", ".bmp", ".tiff"]:
        convert_image(file_path, output_extension)
    elif file_extension in [".mp3", ".wav", ".ogg", ".flac", ".aac", ".mp4", ".avi", ".mkv", ".mov"]:
        convert_media(file_path, output_extension)
    else:
        logging.error(f"Unsupported file type: {file_extension}")

    # Pause the script to keep the CMD window open
    if sys.stdin and sys.stdout:
        input("Press any key to exit...")
