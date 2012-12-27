echo ============================================
echo 'Clean up directories from tmp files'
echo ============================================
cd ../
find ./ganbarou_jb -name *.*~ -exec rm -rf {} \;
cd ganbarou_jb
echo ============================================
echo 'Push latest changes done for tablet'
echo ============================================
echo ============================================
echo 'Push latest changes to beegee-tokyo vendor_p4'
echo ============================================
cd vendor
cd samsung
cd p4
#repo start ics .
repo start jellybean .
git checkout jellybean
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_vendor_samsung_p4.git jellybean
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo vendor_p4wifi'
echo ============================================
cd vendor
cd samsung
cd p4wifi
#repo start ics .
repo start jellybean .
git checkout jellybean
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_vendor_samsung_p4wifi.git jellybean
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo vendor_n7000'
echo ============================================
cd vendor
cd samsung
cd n7000
#repo start ics .
repo start master .
git checkout master
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_vendor_samsung_n7000.git master
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo vendor_galaxys2-common'
echo ============================================
cd vendor
cd samsung
cd galaxys2-common
#repo start ics .
repo start master .
git checkout master
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_vendor_samsung_galaxys2-common.git master
cd ../../..
echo ============================================
echo 'Push latest changes to Wallpapers'
echo ============================================
cd packages
cd apps
cd Wallpapers
repo start ics .
git checkout ics
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_packages_apps_g_Wallpapers.git ics
cd ../../..
echo ============================================
echo 'Push latest changes to settings'
echo ============================================
cd packages
cd apps
cd Settings
#repo start ics .
repo start jellybean .
git checkout jellybean
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_packages_apps_g_Settings.git jellybean
cd ../../..
echo ============================================
echo 'Push latest changes to CyanogenMod framework'
echo ============================================
cd frameworks
cd base
repo start jellybean .
git checkout jellybean
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_frameworks_base.git jellybean
cd ../..
echo ============================================
echo 'Push latest changes to Ganbarou Tools'
echo ============================================
cd ganbarou_tools
repo start master .
git checkout master
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/ganbarou_tools.git master
cd ..

echo ============================================
echo 'Temporary exit'
   exit $?
echo ============================================
#echo ============================================
#echo ============================================
#echo ============================================
#echo ============================================

echo ============================================
echo 'Push latest changes to beegee-tokyo device_p4'
echo ============================================
cd device
cd samsung
cd p4
repo start ics .
git checkout ics
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4.git ics
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo device_p4wifi'
echo ============================================
cd device
cd samsung
cd p4wifi
repo start ics .
git checkout ics
git pull
git add -A
git commit -a
git push  git@github.com:beegee-tokyo/android_device_samsung_p4wifi.git ics
cd ../../..
#echo ============================================
#echo 'Push latest changes to beegee-tokyo device_p4-common'
#echo ============================================
#cd device
#cd samsung
#cd p4-common
#repo start ics .
#git checkout ics
#git pull
#git add -A
#git commit -a
#git push git@github.com:beegee-tokyo/android_device_samsung_p4-common.git ics
#cd ../../..

echo ============================================
echo 'Push latest changes done for phone'
echo ============================================
echo ============================================
echo 'Push latest changes to CyanogenMod device_n7000'
echo ============================================
cd device
cd samsung
cd n7000
repo start ics .
git checkout ics
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_g_N7000.git ics
cd ../../..

echo ============================================
echo 'Push latest changes done for settings and apps'
echo ============================================
#echo ============================================
#echo 'Push changes in vendor samsung'
#echo ============================================
#cd vendor
#cd samsung
#repo start master .
#git checkout master
#git add -A
#git commit -a
#git push  git@github.com:beegee-tokyo/ganbarou-vendor.git master
#cd ../..
echo ============================================
echo 'Push latest changes to CyanogenMod framework'
echo ============================================
cd frameworks
cd base
repo start ics .
git checkout ics
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_frameworks_base.git ics
cd ../..
echo ============================================
echo 'Check output. If all ok start ./sync.sh'
echo ============================================
