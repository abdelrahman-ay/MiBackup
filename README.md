Windows Batchfile script to backup and restore MI and Redmi devices data with advanced capabilities using adb and fastboot functions

# Features:
- option to automate whatsapp data local backup first 
- Folder numbering system allowing multiple backups at the same time
- backup folder choosing to allow restoring older backup
- option to specify which folders to backup 
- restore is automated for all backed up folders
- option to safely remove bloatware apps by disabling apps instead of uninstalling
- option to restart phone to bootloader after backup 
- option to restart phone to system after restore 
- don't need external files to work (adb and fastboot included)
- for windows devices (phone ~ windows backup) and planned bash support (phone ~ phone backup planned in future release)

# Currently able to backup and restore:
+ Whatsapp backup folder
+ DCIM folder (Camera folder)
+ Pictures folder
+ Downloads folder
+ xiaomi control center icons and arrangement data
+ some apps with it's appdata
+ Magisk Modules

# Currently able to backup only (restore option not guranteed to work)
+ system settings
+ secure settings
+ global settings
