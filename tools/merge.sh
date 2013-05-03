echo ============================================
echo 'Get latest changes from pershoot vendor_p4'
echo ============================================
cd vendor
cd samsung
cd p4
git checkout cm-10.1
git remote add upstream git://github.com/pershoot/android_vendor_samsung_p4.git
git fetch upstream
git merge upstream/cm-10.1
cd ../../..
echo ============================================
echo 'Get latest changes from pershoot vendor_p4wifi'
echo ============================================
cd vendor
cd samsung
cd p4wifi
git checkout cm-10.1
git remote add upstream git://github.com/pershoot/android_vendor_samsung_p4wifi.git
git fetch upstream
git merge upstream/cm-10.1
cd ../../..
echo ============================================
echo 'Get latest changes from cyanogenmod device_p4'
echo ============================================
cd device
cd samsung
cd p4
git checkout cm-10.1
git remote add upstream git://github.com/CyanogenMod/android_device_samsung_p4.git
git fetch upstream
git merge upstream/cm-10.1
cd ../../..
echo ============================================
echo 'Get latest changes from cyanogenmod device_p4wifi'
echo ============================================
cd device
cd samsung
cd p4wifi
git checkout cm-10.1
git remote add upstream git://github.com/CyanogenMod/android_device_samsung_p4wifi.git
git fetch upstream
git merge upstream/cm-10.1
cd ../../..
echo ============================================
echo 'Get latest changes from cyanogenmod device_p4-common'
echo ============================================
cd device
cd samsung
cd p4-common
git checkout cm-10.1
git remote add upstream git://github.com/CyanogenMod/android_device_samsung_p4-common.git
git fetch upstream
git merge upstream/cm-10.1
cd ../../..
echo ============================================
echo 'Get latest changes from settings'
echo ============================================
cd packages
cd apps
cd Settings
git checkout cm-10.1
git remote add upstream git://github.com/CyanogenMod/android_packages_apps_Settings.git
git fetch upstream
git merge upstream/cm-10.1
cd ../../..
echo ============================================
echo 'Get latest changes from CyanogenMod framework'
echo ============================================
cd frameworks
cd base
git checkout cm-10.1
git remote add upstream git://github.com/CyanogenMod/android_frameworks_base.git
git fetch upstream
git merge upstream/cm-10.1
cd ../..
echo ============================================
echo 'Get latest changes from rom_stats'
echo ============================================
cd packages
cd apps
cd rom_stats
git checkout master
git remote add upstream git://github.com/mcbyte-it/rom_stats.git
git fetch upstream
git merge upstream/master
cd ../../..
echo ============================================
echo 'Check output. If all ok start ./push.sh'
echo ============================================
