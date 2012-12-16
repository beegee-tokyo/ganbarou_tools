echo ============================================
echo 'Get latest changes from pershoot vendor_p4'
echo ============================================
cd vendor
cd samsung
cd p4
git checkout jellybean
git remote add upstream git://github.com/pershoot/android_vendor_samsung_p4.git
git fetch upstream
git merge upstream/jellybean
cd ../../..
echo ============================================
echo 'Get latest changes from pershoot vendor_p4wifi'
echo ============================================
cd vendor
cd samsung
cd p4wifi
git checkout jellybean
git remote add upstream git://github.com/pershoot/android_vendor_samsung_p4wifi.git
git fetch upstream
git merge upstream/jellybean
cd ../../..
echo ============================================
echo 'Get latest changes from settings'
echo ============================================
cd packages
cd apps
cd Settings
git checkout jellybean
git remote add upstream git://github.com/CyanogenMod/android_packages_apps_Settings.git
git fetch upstream
git merge upstream/jellybean
cd ../../..
echo ============================================
echo 'Get latest changes from CyanogenMod framework'
echo ============================================
cd frameworks
cd base
git checkout jellybean
git remote add upstream git://github.com/CyanogenMod/android_frameworks_base.git
git fetch upstream
git merge upstream/jellybean
cd ../..

echo ============================================
echo 'Temporary exit'
   exit $?
echo ============================================
#echo ============================================
#echo ============================================
#echo ============================================
#echo ============================================

echo ============================================
echo 'Get latest changes from pershoot vendor_p4wifi'
echo ============================================
cd vendor
cd samsung
cd p4wifi
git checkout ics
git remote add upstream git://github.com/pershoot/android_vendor_samsung_p4wifi.git
git fetch upstream
git merge upstream/ics
cd ../../..
echo ============================================
echo 'Get latest changes from pershoot device_p4'
echo ============================================
cd device
cd samsung
cd p4
git checkout ics
git remote add upstream git://github.com/pershoot/android_device_samsung_p4.git
git fetch upstream
git merge upstream/ics
cd ../../..
echo ============================================
echo 'Get latest changes from pershoot device_p4wifi'
echo ============================================
cd device
cd samsung
cd p4wifi
git checkout ics
git remote add upstream git://github.com/pershoot/android_device_samsung_p4wifi.git
git fetch upstream
git merge upstream/ics
cd ../../..
#echo ============================================
#echo 'Get latest changes from pershoot device_p4-common'
#echo ============================================
#cd device
#cd samsung
#cd p4-common
#git checkout ics
#git remote add upstream git://github.com/pershoot/android_device_samsung_p4-common.git
#git fetch upstream
#git merge upstream/ics
#cd ../../..

echo ============================================
echo 'Get latest changes from CyanogenMod device_n7000'
echo ============================================
cd device
cd samsung
cd n7000
git checkout ics
git remote add upstream git://github.com/CyanogenMod/android_device_samsung_n7000.git
git fetch upstream
git merge upstream/ics
cd ../../..

echo ============================================
echo 'Get latest changes from CyanogenMod framework'
echo ============================================
cd frameworks
cd base
git checkout ics
git remote add upstream git://github.com/CyanogenMod/android_frameworks_base.git
git fetch upstream
git merge upstream/ics
cd ../..
echo ============================================
echo 'Check output. If all ok start ./push.sh'
echo ============================================
