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
echo - Backup Script V1.6
echo - for MI and REDMI devices
echo - WORKS ON : Whatsapp backup folder, Magisk Modules folder, DCIM folder, Pictures folder, Downloads folder, sysuiplugin arrangement data, app, appdata
echo - Creator: AYS
echo.
echo.
setlocal EnableDelayedExpansion
set "folder_name=backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%"
set "i=0"
set "new_folder_name=%folder_name%"
if exist "%folder_name%" (
    :loop
    set /a i+=1
    set "new_folder_name=%folder_name%_!i!"
    if exist "!new_folder_name!" (
        goto :loop
    ) else (
        mkdir "!new_folder_name!"
        echo Created folder: "!new_folder_name!"
    )
) else (
    mkdir "%new_folder_name%"
    echo Created folder: "%new_folder_name%"
)
set "backup_folder=%new_folder_name%"
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
mkdir %backup_folder%
echo.
mkdir %backup_folder%"/Whatsapp/"
mkdir %backup_folder%"/Modules/"
mkdir %backup_folder%"/Downloads/"
mkdir %backup_folder%"/DCIM/"
mkdir %backup_folder%"/Pictures/"
mkdir %backup_folder%"/MIUIBackup/"
mkdir %backup_folder%"/Settings/"
echo.
echo.
%adb% backup -apk -nosystem -all -f %backup_folder%/Settings/apps_%backup_folder%.ab || @echo "ERROR: apps backup failed" && pause
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
%adb% pull /storage/emulated/0/Android/media/com.whatsapp/ "%backup_folder%/Whatsapp/" || @echo "ERROR: WHATSAPP data backup failed" && pause
echo.
echo Modules: 
echo.
%adb% shell su -c cp -r -p /data/adb/modules/ /storage/emulated/0/TempBackupFilesModules/ && @echo. - step 1 Done. || @echo "ERROR: MODULES data backup failed" && pause
%adb% pull /storage/emulated/0/TempBackupFilesModules/ "%backup_folder%/Modules/" && @echo. - step 2 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo CLEANING UP
%adb% shell rm -r /storage/emulated/0/TempBackupFilesModules/ && @echo. - step 3 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo.
echo Downloads: 
echo.
%adb% pull /storage/emulated/0/Download/ "%backup_folder%/Downloads" || @echo "ERROR: DOWNLOADS folder backup failed" && pause
echo.
echo Camera: 
echo.
%adb% pull /storage/emulated/0/DCIM/ "%backup_folder%/DCIM/" || @echo "ERROR: DCIM folder backup failed" && pause
echo.
echo Pictures: 
echo.
%adb% pull /storage/emulated/0/Pictures/ "%backup_folder%/Pictures/" || @echo "ERROR: PICTURES folder backup failed" && pause
echo.
echo MIUI Backup: 
echo.
%adb% pull /storage/emulated/0/MIUI/backup/AllBackup/ "%backup_folder%//MIUIBackup/" || @echo "ERROR: BACKUP folder backup failed" && pause
echo.
echo Other System Data: 
echo.
%adb% shell settings get secure sysui_qs_tiles > %backup_folder%/Settings/sysui_qs_tiles.txt || @echo "ERROR: sysui_qs_tiles backup failed" && pause
echo.
%adb% shell settings list system > %backup_folder%/Settings/system.1.2.txt || @echo "ERROR: system settings backup failed" && pause
echo.
%adb% shell settings list secure > %backup_folder%/Settings/secure.1.2.txt || @echo "ERROR: secure settings backup failed" && pause
echo.
%adb% shell settings list global > %backup_folder%/Settings/global.1.2.txt || @echo "ERROR: global settings backup failed" && pause
echo.
echo - Backup finsihed
echo. 
echo.
set /p rebooting=-- Do you want to reboot to bootloader ? (Y/N)
if /i "%rebooting%" equ "y" echo rebooting to bootloader && %adb% reboot bootloader
pause