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
echo - Restore Script V1.6
echo - for MI & REDMI devices
echo - WORKS ON : Whatsapp backup folder, Magisk Modules folder, DCIM folder, Pictures folder, Downloads folder, Control Center data, Apps, Appdata
echo - Creator: AYS
echo.
echo.
setlocal EnableDelayedExpansion
:select_backup_folder
echo Available backup folders:
set "i=0"
for /f "tokens=*" %%a in ('dir /b /ad backup_*') do (
    set /a i+=1
    echo !i!. %%a
)
set /p "choice=Enter the number corresponding to the backup folder: "
if "%choice%" geq "1" if "%choice%" leq "!i!" (
    set "selected_folder="
    for /f "tokens=1,* delims= " %%a in ('dir /b /ad backup_*') do (
        set /a choice-=1
        if "!choice!"=="0" (
            set "selected_folder=%%a"
            goto :folder_selected
        )
    )
) else (
    echo Invalid choice. Please enter a number between 1 and !i!
    goto :select_backup_folder
)
:folder_selected
echo Selected backup folder: %selected_folder%
echo.
echo.
echo ##################################################################################
echo - Please wait. The device will reboot when installation is finished.
echo ##################################################################################
echo.
echo.
echo.
echo.
echo.
%adb% restore %selected_folder%/Settings/apps_%selected_folder%.ab || @echo "ERROR: apps restore failed" && pause
echo.
echo.
echo Whatsapp: 
echo.
%adb% push "%selected_folder%/Whatsapp/com.whatsapp/" /storage/emulated/0/Android/media/ || @echo "ERROR: WHATSAPP data restore failed" && pause
echo.
echo Modules: 
echo.
%adb% push "%selected_folder%/Modules/modules/" /storage/emulated/0/modules/ || @echo "ERROR: MODULES data restore failed step 1"
%adb% push /storage/emulated/0/modules/ /data/adb/ || @echo "ERROR: MODULES data restore failed step 2"
echo.
echo Downloads: 
echo.
%adb% push "%selected_folder%/Downloads/Download/" /storage/emulated/0/ || @echo "ERROR: DOWNLOADS folder restore failed" && pause
echo.
echo Camera: 
echo.
%adb% push "%selected_folder%/DCIM/DCIM/" /storage/emulated/0/ || @echo "ERROR: DCIM folder restore failed" && pause
echo.
echo Pictures: 
echo.
%adb% push "%selected_folder%/Pictures/Pictures/" /storage/emulated/0/ || @echo "ERROR: PICTURES folder restore failed" && pause
echo.
echo MIUI Backup: 
echo.
%adb% push "%selected_folder%/MIUIBackup/AllBackup/" /storage/emulated/0/MIUI/backup/ || @echo "ERROR: BACKUP folder restore failed" && pause
echo.
echo - do you want to remove Bloatware ? 
echo - press 1 if yes
echo - press 2 if not
echo.
set /p BloatwareCheck=-- Type your option: (1/2)  
echo.
if %BloatwareCheck% equ "1"  echo - Removing bloatware ...
echo.
echo.
echo.
if %BloatwareCheck% equ "1"  echo clearing packages data
echo.
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.miui.screenrecorder
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.fmradio
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.google.android.googlequicksearchbox
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.miui.fm
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.google.android.apps.googleassistant
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.miui.videoplayer
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.soundrecorder
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.providers.downloads.ui
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.hotwordenrollment.xgoogle
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.nfc
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.stk
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.xiaomi.simactivate.service
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.miui.cleaner
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.printspooler
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.hotwordenrollment.okgoogle
if %BloatwareCheck% equ "1"  %adb% shell pm clear de.telekom.tsc
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.bips
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.android.chrome
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.google.android.tts
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.miui.touchassistant
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.google.android.projection.gearhead
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.google.android.gms.location.history
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.xiaomi.discover
if %BloatwareCheck% equ "1"  %adb% shell pm clear com.miui.fmservice
echo.
if %BloatwareCheck% equ "1"  echo disabling packages.
echo.
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.miui.screenrecorder
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.fmradio
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.google.android.googlequicksearchbox
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.miui.fm
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.google.android.apps.googleassistant
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.miui.videoplayer
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.soundrecorder
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.providers.downloads.ui
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.hotwordenrollment.xgoogle
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.nfc
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.stk
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.xiaomi.simactivate.service
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.miui.cleaner
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.printspooler
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.hotwordenrollment.okgoogle
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user de.telekom.tsc
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.bips
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.android.chrome
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.google.android.tts
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.miui.touchassistant
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.google.android.projection.gearhead
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.google.android.gms.location.history
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.xiaomi.discover
if %BloatwareCheck% equ "1"  %adb% shell pm disable-user com.miui.fmservice
echo.
echo Other System Data (Might Cause bugs and not work correctly procced with caution): 
echo - RESTORE THE FOLLOWING FILES MANUALLY
echo.
echo - Do you want to restore Control Center settings ?
echo - press 1 if yes
echo - press 2 if not (Recommended)
echo.
set /p ControlCenter=-- Type your option: (1/2) 
if /i "%ControlCenter%" equ "y" %adb% shell settings put secure sysui_qs_tiles %selected_folder%/Settings/sysui_qs_tiles.txt || @echo "ERROR: sysui_qs_tiles Restore failed" && pause
echo.
echo - Do you want to restore system settings ?
echo - press 1 if yes
echo - press 2 if not (Recommended)
echo.
set /p system=-- Type your option: (1/2) 
if /i "%system%" equ "1" echo restoring system settings && %adb% shell settings put system %selected_folder%/Settings/system.1.2.txt
echo.
echo - Do you want to restore secure settings ?
echo - press 1 if yes
echo - press 2 if not (Recommended)
echo.
set /p secure=-- Type your option: (1/2) 
if /i "%secure%" equ "1" echo restoring secure settings && %adb% shell settings put secure %selected_folder%/Settings/secure.1.2.txt
echo.
echo - Do you want to restore global settings ?
echo - press 1 if yes
echo - press 2 if not (Recommended)
echo.
set /p global=-- Type your option: (1/2) 
if /i "%global%" equ "1" echo restoring global settings && %adb% shell settings put global %selected_folder%/Settings/global.1.2.txt
echo.
echo.
echo.
echo - Do you want to reboot system ?
echo - press 1 if yes
echo - press 2 if not
echo.
set /p rebooting=-- Type your option: (1/2) 
if /i "%rebooting%" equ "1" echo rebooting && %adb% reboot 
pause