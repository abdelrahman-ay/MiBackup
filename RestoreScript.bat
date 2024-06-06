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
echo - Restore Script V1.5
echo - for MI & REDMI devices
echo - WORKS ON : Whatsapp backup folder, Magisk Modules folder, DCIM folder, Pictures folder, Downloads folder, Control Center data, Apps, Appdata
echo - Creator: AYS
echo.
echo.
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

%adb% restore backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/apps_backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%.ab || @echo "ERROR: apps restore failed" && pause
echo.
echo.
echo Whatsapp: 
echo.
%adb% push "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Whatsapp/com.whatsapp/" /storage/emulated/0/Android/media/ || @echo "ERROR: WHATSAPP data restore failed" && pause
echo.
echo Modules: 
echo.
%adb% push "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Modules/modules/" /storage/emulated/0/modules/ || @echo "ERROR: MODULES data restore failed step 1"
%adb% push /storage/emulated/0/modules/ /data/adb/ || @echo "ERROR: MODULES data restore failed step 2"
echo.
echo Downloads: 
echo.
%adb% push "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Downloads/Download/" /storage/emulated/0/ || @echo "ERROR: DOWNLOADS folder restore failed" && pause
echo.
echo Camera: 
echo.
%adb% push "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/DCIM/DCIM/" /storage/emulated/0/ || @echo "ERROR: DCIM folder restore failed" && pause
echo.
echo Pictures: 
echo.
%adb% push "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Pictures/Pictures/" /storage/emulated/0/ || @echo "ERROR: PICTURES folder restore failed" && pause
echo.
echo MIUI Backup: 
echo.
%adb% push "backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%//MIUIBackup/AllBackup/" /storage/emulated/0/MIUI/backup/ || @echo "ERROR: BACKUP folder restore failed" && pause
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
echo Other System Data: 
echo.
set /p ControlCenter=-- Do you want to restore Control Center settings ? (Y/N)
if /i "%ControlCenter%" equ "y" %adb% shell settings put secure sysui_qs_tiles backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/sysui_qs_tiles.txt || @echo "ERROR: sysui_qs_tiles Restore failed" && pause

echo.
set /p system=-- Do you want to restore system settings ? (Y/N)
if /i "%system%" equ "y" echo restoring system settings && %adb% shell settings put system backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/system.1.2.txt
echo.

echo.
set /p secure=-- Do you want to restore secure settings ? (Y/N)
if /i "%secure%" equ "y" echo restoring secure settings && %adb% shell settings put secure backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/secure.1.2.txt
echo.

echo.
set /p global=-- Do you want to restore global settings ? (Y/N)
if /i "%global%" equ "y" echo restoring global settings && %adb% shell settings put global backup_%date:~-7,2%%date:~-10,2%%date:~-4,4%/Settings/global.1.2.txt
echo.



echo.
set /p rebooting=-- Do you want to reboot system ? (Y/N)
if /i "%rebooting%" equ "y" echo rebooting && %adb% reboot 
pause