@echo off
REM Get the directory of the batch file
SET "SCRIPT_DIR=%~dp0"
SET "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"  REM Remove trailing backslash if present

REM Define paths
SET "SCRIPT_PATH=%SCRIPT_DIR%\convert_media.py"
SET "COMPRESS_SCRIPT_PATH=%SCRIPT_DIR%\compress_video.py"

REM Detect the full path of python.exe
FOR /F "delims=" %%I IN ('where python.exe') DO SET "PYTHON_PATH=%%I"

REM If python.exe is not found, show an error and exit
IF NOT DEFINED PYTHON_PATH (
    echo python.exe not found in PATH. Ensure Python is installed and added to PATH.
    pause
    exit /b
)

:: Create context menu

:: IMAGE FILES
for %%X in (jpg jpeg png bmp tiff webp jfif) do (
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Convert Image" /v "MUIVerb" /d "Convert Image" /f
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Convert Image" /v "SubCommands" /d "Convert.Image.JPEG;Convert.Image.PNG" /f
)

:: AUDIO FILES
for %%X in (mp3 wav ogg flac aac) do (
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Convert Audio" /v "MUIVerb" /d "Convert Audio" /f
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Convert Audio" /v "SubCommands" /d "Convert.Audio.MP3;Convert.Audio.WAV" /f
)

:: VIDEO FILES
for %%X in (mp4 avi mkv mov) do (
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Convert Video" /v "MUIVerb" /d "Convert Video" /f
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Convert Video" /v "SubCommands" /d "Convert.Video.MP4;Convert.Video.AVI" /f
)

:: COMPRESS VIDEO FILES
for %%X in (mp4 avi) do (
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Compress Video" /v "MUIVerb" /d "Compress Video" /f
    reg add "HKCR\SystemFileAssociations\.%%X\shell\Compress Video\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%COMPRESS_SCRIPT_PATH%\" \"%%1\"" /f
)

:: Create command store entries

:: IMAGE COMMANDS
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.JPEG" /ve /d "Convert to JPEG" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.JPEG\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%SCRIPT_PATH%\" \"%%1\" jpeg" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.PNG" /ve /d "Convert to PNG" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.PNG\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%SCRIPT_PATH%\" \"%%1\" png" /f

:: AUDIO COMMANDS
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.MP3" /ve /d "Convert to MP3" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.MP3\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%SCRIPT_PATH%\" \"%%1\" mp3" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.WAV" /ve /d "Convert to WAV" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.WAV\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%SCRIPT_PATH%\" \"%%1\" wav" /f

:: VIDEO COMMANDS
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.MP4" /ve /d "Convert to MP4" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.MP4\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%SCRIPT_PATH%\" \"%%1\" mp4" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.AVI" /ve /d "Convert to AVI" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.AVI\command" /ve /t REG_EXPAND_SZ /d "\"%PYTHON_PATH%\" \"%SCRIPT_PATH%\" \"%%1\" avi" /f

echo Registry setup complete!
pause
