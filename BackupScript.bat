@echo off
cls
cd %~dp0
echo.
set fastboot=ADB\fastboot.exe
set adb=ADB\adb.exe
set backup=backup\
if not exist %fastboot% echo - %fastboot% is not found. [Script is corrupted] Put all script files in the backup directory. & pause & exit /B 1
if not exist %adb% echo - /%adb% folder is not found. [Adb is not detected] Put all script files in the backup directory. & pause & exit /B 1
echo - Waiting for device... (Install drivers to continue)
cls
echo - Backup Script V1.5
echo - for MI & REDMI devices
echo - WORKS ON : Whatsapp backup folder, Magisk Modules folder, DCIM folder, Pictures folder, Downloads folder, sysuiplugin arrangement data, app, appdata
echo - Creator: AYS
echo.
echo.
echo.
echo.
echo.
echo.
echo - do you have applock for whatsapp ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p applockcheck=-- Type your option: (1/2)  
echo.
echo.
echo ##################################################################################
echo - Please wait. The device will reboot to bootloader when installation is finished.
echo ##################################################################################
echo.
echo.
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%
echo.
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/Whatsapp/"
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/Modules/"
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/Downloads/"
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/DCIM/"
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/Pictures/"
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/MIUIBackup/"
mkdir backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"/Settings/"
echo.
echo.
%adb% backup -apk -nosystem -all -f backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/apps_backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%.ab || @echo "ERROR: apps backup failed" && pause
echo.
echo Whatsapp: 
echo.
%adb% shell am force-stop com.whatsapp
timeout /t 3 /nobreak >nul
%adb% shell su -c am start -n com.whatsapp/.backup.google.SettingsGoogleDrive
adb shell input keyevent 66
echo.
if %applockcheck% equ "2" adb shell input keyevent 66
if %applockcheck% equ "1" echo Input your password and press Back up
echo.
echo Press ENTER to continue when Whatsapp data backup finish  
timeout /t -1 >nul
echo - Continuing with Backup
echo.
echo Make A Local Whatsapp data Backup 
echo.
%adb% pull /storage/emulated/0/Android/media/com.whatsapp/ "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Whatsapp/" || @echo "ERROR: WHATSAPP data backup failed" && pause
echo.
echo Modules: 
echo.
%adb% shell su -c cp -r -p /data/adb/modules/ /storage/emulated/0/TempBackupFilesModules/ && @echo. - step 1 Done. || @echo "ERROR: MODULES data backup failed" && pause
%adb% pull /storage/emulated/0/TempBackupFilesModules/ "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Modules/" && @echo. - step 2 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo CLEANING UP
%adb% shell rm -r /storage/emulated/0/TempBackupFilesModules/ && @echo. - step 3 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo.
echo Downloads: 
echo.
%adb% pull /storage/emulated/0/Download/ "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Downloads" || @echo "ERROR: DOWNLOADS folder backup failed" && pause
echo.
echo Camera: 
echo.
%adb% pull /storage/emulated/0/DCIM/ "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/DCIM/" || @echo "ERROR: DCIM folder backup failed" && pause
echo.
echo Pictures: 
echo.
%adb% pull /storage/emulated/0/Pictures/ "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Pictures/" || @echo "ERROR: PICTURES folder backup failed" && pause
echo.
echo MIUI Backup: 
echo.
%adb% pull /storage/emulated/0/MIUI/backup/AllBackup/ "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%//MIUIBackup/" || @echo "ERROR: BACKUP folder backup failed" && pause
echo.
echo Other System Data: 
echo.
%adb% shell settings get secure sysui_qs_tiles > backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/sysui_qs_tiles.txt || @echo "ERROR: sysui_qs_tiles backup failed" && pause
echo.
%adb% shell settings list system > backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/system.1.2.txt || @echo "ERROR: system settings backup failed" && pause
echo.
%adb% shell settings list secure > backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/secure.1.2.txt || @echo "ERROR: secure settings backup failed" && pause
echo.
%adb% shell settings list global > backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/global.1.2.txt || @echo "ERROR: global settings backup failed" && pause
echo.
echo - Backup finsihed
echo. 
echo.
set /p rebooting=-- Do you want to reboot to bootloader ? (Y/N)
if /i "%rebooting%" equ "y" echo rebooting to bootloader && %adb% reboot bootloader
pause