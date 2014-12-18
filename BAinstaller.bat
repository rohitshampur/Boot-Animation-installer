
@echo off
@title Custom Boot Animation Selection Menu
@cls
color 0a

:RESTART

cd "%~dp0"

set menunr=GARBAGE

cls

echo ******************************************************************************
echo *                         BOOT ANIMATION INSTALLER                           *
echo *                                  By                                        *
echo *                        Rohit99 a.k.a stormtheh4ck3r                        *
echo ******************************************************************************
echo *     NOTE:                                                                  *
echo *     (*) Only for ROOTED phones                                             *
echo *     (*) Place the bootanimation.zip you want to flash                      *
echo *         into folder "place_bootanimation_here"                             *
echo *     (*) Make sure u have installed ADB drivers for your device             *
echo *     (*) Enable "USB DEBUGGING"                                             *
echo *     (*) Connect USB cable to PHONE and then connect to PC                  *
echo *     (*) Unlock the screen                                                  * 
echo *     (*) Make sure that your PC firewall doesn't block "adb.exe"            *
echo *============================================================================*
echo *     DISCLAIMER :                                                           *
echo *            I am not responsible for bricked devices , use at your          *
echo *            own risk                                                        *
echo *============================================================================* 
echo *         [*]  1. Backup the current Boot Animation                          *
echo *                 This will back up the current Boot Animation               *
echo *                 to a backup folder                                         *
echo ******************************************************************************
echo *         [*]  2. Install new Boot Animation                                 *
echo *                This will install new Boot Animation from the               *
echo *                 place_bootanimation_here folder                            *
echo ******************************************************************************  	
echo *         [*]  3. Restore Previous Boot Animation                            *
echo *                This Restores the Boot Animation from the backup            *
echo *                Folder                                                      *
echo ******************************************************************************
echo *         [*]  4.About                                                       * 
echo ******************************************************************************
echo *         [*]  0.Exit the Installer                                          *
echo ******************************************************************************

SET /P menunr= what can i do for you ?? :
IF %menunr%==1 (goto backup)
IF %menunr%==2 (goto install)
IF %menunr%==3 (goto remove)
IF %menunr%==4 (goto about)
IF %menunr%==0 (goto Quit)

echo ******************************************************************************
echo *                      Please enter a Valid choice                           *
echo ******************************************************************************
PAUSE
GOTO RESTART

:install
@title Flashing New Boot Animation...
@echo off
echo.
echo Starting ADB Server
tools\adb kill-server
tools\adb start-server
echo Waiting for Device...
tools\adb wait-for-device
echo.
echo Device detected
echo.
echo Press any key to install new Boot Animation
pause > nul
tools\adb push "%~dp0place_bootanimation_here\bootanimation.zip" /data/local/tmp/bootanimation.zip 
echo Press "Grant" Root Access on your device screen
echo Press any key to continue
tools\adb shell " su -c 'mount -o remount,rw /system'"
pause 
tools\adb shell " su -c 'cp /data/local/tmp/bootanimation.zip /system/media'"
tools\adb shell " su -c 'chmod 0644 /system/media/bootanimation.zip'"
tools\adb shell "rm -rf /data/local/tmp/bootanimation.zip" 
echo.
echo  Installation Complete..
echo.
echo  Rebooting Device
tools\adb reboot
tools\adb wait-for-device
echo.
echo Successfully Installed the new Boot Animation
echo Press any key to Continue
pause > nul
GOTO RESTART

:backup
echo Starting ADB Server
tools\adb kill-server
tools\adb start-server
echo Waiting for Device...
tools\adb wait-for-device
echo.
echo Device detected
echo Press any key to back up current Boot Animation
pause > nul
echo.
echo Backing up current boot animation...
echo.
tools\adb pull /system/media/bootanimation.zip "backup/bootanimation.zip" 
echo Backup Complete
echo.
echo Press any key to continue
pause > nul
GOTO RESTART


:remove
echo Starting ADB Server
tools\adb kill-server
tools\adb start-server
echo Waiting for Device...
tools\adb wait-for-device
echo.
echo Device detected
echo.
echo Press any key to Restore previous Boot Animation
pause > nul
tools\adb push "%~dp0backup\bootanimation.zip" /data/local/tmp/bootanimation.zip
echo Press "Grant" Root Access on your device screen
tools\adb shell " su -c 'mount -o remount,rw /system'"
pause
tools\adb shell "su -c 'cp /data/local/tmp/bootanimation.zip /system/media'"
tools\adb shell "su -c 'chmod 0644 /system/media/bootanimation.zip'"
tools\adb shell "rm -rf /data/local/tmp/bootanimation.zip"
echo.
echo  Restore Complete..
echo.
echo  Rebooting Device
tools\adb reboot
echo.
echo Successfully Restored the previous Boot Animation
echo Press any key to Continue
pause > nul
GOTO RESTART

:Quit
exit

:about
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo +                          App Version : v1.0                                +
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
echo +                            Developed by                                    +
echo +                      Rohit99 a.k.a stormtheh4ck3r                          +
echo +      xda profile :http://forum.xda-developers.com/member.php?u=5684029     +
echo ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++               
echo Press any key to continue
pause > nul
GOTO RESTART
