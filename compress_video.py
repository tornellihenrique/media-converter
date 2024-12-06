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

def compress_video(input_file):
    logging.info(f"Starting video compression: {input_file}")
    base_name, extension = os.path.splitext(input_file)
    extension = extension.lower()

    # Supported formats: .mp4 and .avi
    if extension not in [".mp4", ".avi"]:
        logging.error(f"Unsupported video format: {extension}. Only .mp4 and .avi are supported.")
        return

    output_file = f"{base_name}(compress){extension}"
    logging.info(f"Output file will be: {output_file}")

    # ffmpeg -i "%i" -crf 23 -preset medium -movflags +faststart -c:a aac "%output.mp4"
    command = [
        "ffmpeg",
        "-i", input_file,
        "-crf", "23",
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
            logging.error(f"FFmpeg failed with return code {process.returncode}")
    except Exception as e:
        logging.error(f"Error during video compression: {e}", exc_info=True)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        logging.error("Invalid arguments. Usage: compress_video.py <file_path>")
        sys.exit(1)

    file_path = sys.argv[1]

    if not os.path.exists(file_path):
        logging.error(f"File not found: {file_path}")
        sys.exit(1)

    compress_video(file_path)

    # Pause the script if running in a console to allow the user to view the output
    if sys.stdin and sys.stdout:
        input("Press any key to exit...")