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
echo - Backup Script V1.7
echo - for MI and REDMI devices
echo - WORKS ON : Whatsapp backup folder, Magisk Modules folder, DCIM folder, Pictures folder, Downloads folder, Control Center data, Apps, Appdata
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
echo - automate Whatsapp local data backup ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p WspBck=-- Type your option: (1/2)  
echo.
echo.
echo ##################################################################################
echo - Please wait. The device will reboot to bootloader when installation is finished.
echo ##################################################################################
echo.
echo.
mkdir %backup_folder%
echo.
mkdir %backup_folder%"/Settings/"
echo.
echo.
%adb% backup -apk -nosystem -all -f %backup_folder%/Settings/apps_%backup_folder%.ab || @echo "ERROR: apps backup failed" && pause
echo.
echo Whatsapp: 
echo.
if %WspBck% equ "1" %adb% shell am force-stop com.whatsapp
timeout /t 3 /nobreak >nul
if %WspBck% equ "1" %adb% shell su -c am start -n com.whatsapp/.backup.google.SettingsGoogleDrive
echo.
if %WspBck% equ "1" %adb% shell input keyevent 66
echo.
if %WspBck% equ "1" %adb% shell input keyevent 66
echo.
if %WspBck% equ "1" echo Press ENTER when Whatsapp data backup finish  
timeout /t -1 >nul
echo - Continuing with Backup
echo.
echo Make A Local Whatsapp data Backup 
echo.
echo - Backup Whatsapp data ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p Wsp=-- Type your option: (1/2)  
echo.
if %Wsp% equ "1" mkdir %backup_folder%"/Whatsapp/"
echo.
if %Wsp% equ "1" %adb% pull /storage/emulated/0/Android/media/com.whatsapp/ "%backup_folder%/Whatsapp/" || @echo "ERROR: WHATSAPP data backup failed" && pause
echo.
echo Modules: 
echo.
echo - backup Modules data ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p modules=-- Type your option: (1/2)  
echo.
if %modules% equ "1" mkdir %backup_folder%"/Modules/"
echo.
if %modules% equ "1" %adb% shell su -c cp -r -p /data/adb/modules/ /storage/emulated/0/TempBackupFilesModules/ && @echo. - step 1 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo.
if %modules% equ "1" %adb% pull /storage/emulated/0/TempBackupFilesModules/ "%backup_folder%/Modules/" && @echo. - step 2 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo CLEANING UP
if %modules% equ "1" %adb% shell rm -r /storage/emulated/0/TempBackupFilesModules/ && @echo. - step 3 Done. || @echo "ERROR: MODULES data backup failed" && pause
echo.
echo Downloads: 
echo.
echo - backup downloads data ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p downloads=-- Type your option: (1/2)  
echo.
if %downloads% equ "1" mkdir %backup_folder%"/Downloads/"
echo.
if %downloads% equ "1" %adb% pull /storage/emulated/0/Download/ "%backup_folder%/Downloads" || @echo "ERROR: DOWNLOADS folder backup failed" && pause
echo.
echo Camera: 
echo.
echo - backup Camera data ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p cam=-- Type your option: (1/2)  
echo.
if %cam% equ "1" mkdir %backup_folder%"/DCIM/"
echo.
if %cam% equ "1" %adb% pull /storage/emulated/0/DCIM/ "%backup_folder%/DCIM/" || @echo "ERROR: DCIM folder backup failed" && pause
echo.
echo Pictures: 
echo.
echo - backup Pictures data ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p pics=-- Type your option: (1/2)  
echo.
if %pics% equ "1" mkdir %backup_folder%"/Pictures/"
echo.
if %pics% equ "1" %adb% pull /storage/emulated/0/Pictures/ "%backup_folder%/Pictures/" || @echo "ERROR: PICTURES folder backup failed" && pause
echo.
echo MIUI Backup: 
echo.
echo - backup MIUI data ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p midata=-- Type your option: (1/2)  
echo.
if %midata% equ "1" mkdir %backup_folder%"/MIUIBackup/"
echo.
if %midata% equ "1" %adb% pull /storage/emulated/0/MIUI/backup/AllBackup/ "%backup_folder%//MIUIBackup/" || @echo "ERROR: BACKUP folder backup failed" && pause
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