@echo off

echo Deleting registry entries for Convert Media...

:: Delete Image Conversion Entries
reg delete "HKCR\*\shell\Convert Image" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.JPEG" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Image.PNG" /f

:: Delete Audio Conversion Entries
reg delete "HKCR\*\shell\Convert Audio" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.MP3" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Audio.WAV" /f

:: Delete Video Conversion Entries
reg delete "HKCR\*\shell\Convert Video" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.MP4" /f
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\CommandStore\shell\Convert.Video.AVI" /f

echo Registry entries deleted successfully!
pause
