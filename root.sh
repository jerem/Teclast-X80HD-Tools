#!/bin/sh
set -e

SU_ZIP='UPDATE-SuperSU-v2.46.zip'
SU_URL="http://download.chainfire.eu/696/SuperSU/$SU_ZIP?retrieve_file=1"

echo 'Downloading SuperSU update...'
[ -e $SU_ZIP ] || wget -c -U "Mozilla/5.0" "$SU_URL" -O $SU_ZIP

echo 'Extracting SuperSU update...'
unzip $SU_ZIP x86/su common/Superuser.apk

echo 'Rooting...'
adb remount
adb push x86/su /system/xbin/su
adb shell chmod 06755 /system/xbin/su
echo 'SU binary installed.'
adb push common/Superuser.apk /system/app/
adb shell chmod 0644 /system/app/Superuser.apk
echo 'Superuser app installed.'
echo 'Starting SU daemon. This will take 4 seconds...'
adb shell "/system/xbin/su -d & sleep 4"
echo 'SU daemon started.'
adb shell am start -a android.intent.action.MAIN -n eu.chainfire.supersu/.MainActivity
echo 'SuperSU app started.'
rm -fr x86 common $SU_ZIP
echo 'Temporaty files cleanup...'
echo 'MANUAL STEP: In SuperSU app, update SU binary in Normal mode.'
