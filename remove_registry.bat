@echo off

echo Deleting registry entries for Convert Media...

:: Remove Convert Image entries
for %%X in (jpg jpeg png bmp tiff) do (
    reg delete "HKCR\SystemFileAssociations\.%%X\shell\Convert Image" /f
)

:: Remove Convert Audio entries
for %%X in (mp3 wav ogg flac aac) do (
    reg delete "HKCR\SystemFileAssociations\.%%X\shell\Convert Audio" /f
)

:: Remove Convert Video entries
for %%X in (mp4 avi mkv mov) do (
    reg delete "HKCR\SystemFileAssociations\.%%X\shell\Convert Video" /f
)

:: Remove Compress Video entries
for %%X in (mp4 avi) do (
    reg delete "HKCR\SystemFileAssociations\.%%X\shell\Compress Video" /f
)

:: Remove CommandStore entries for Convert operations
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.JPEG" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.PNG" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.MP3" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.WAV" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.MP4" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.AVI" /f

echo All registry entries have been removed!
pause
