_CURRENTPATH=${PWD##*/}
echo ============================================
echo 'Clean up directories from tmp files'
echo ============================================
cd ../
find ./$_CURRENTPATH -name *.*~ -exec rm -rf {} \;
cd $_CURRENTPATH
echo ============================================
echo 'Push latest changes done for tablet'
echo ============================================
#echo ============================================
#echo 'Push latest changes to beegee-tokyo vendor_p4'
#echo ============================================
#cd vendor
#cd samsung
#cd p4
#repo start cm-10.1 .
#git checkout cm-10.1
#git pull
#git add -A
#git commit -a
#git push git@github.com:beegee-tokyo/android_vendor_samsung_p4.git cm-10.1
#cd ../../..
#echo ============================================
#echo 'Push latest changes to beegee-tokyo vendor_p4wifi'
#echo ============================================
#cd vendor
#cd samsung
#cd p4wifi
#repo start cm-10.1 .
#git checkout cm-10.1
#git pull
#git add -A
#git commit -a
#git push git@github.com:beegee-tokyo/android_vendor_samsung_p4wifi.git cm-10.1
#cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo device_p4'
echo ============================================
cd device
cd samsung
cd p4
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4.git cm-10.2
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo device_p4wifi'
echo ============================================
cd device
cd samsung
cd p4wifi
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4wifi.git cm-10.2
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo device_p4-common'
echo ============================================
cd device
cd samsung
cd p4-common
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4-common.git cm-10.2
cd ../../..
#echo ============================================
#echo 'Push latest changes to beegee-tokyo pershoot kernel p4'
#echo ============================================
#cd kernel
#cd samsung
#cd p4_pershoot
#repo start cm-10.1 .
#git checkout cm-10.1
#git pull
#git add -A
#git commit -a
#git push git@github.com:beegee-tokyo/android_kernel_samsung_p4_pershoot.git #cm-10.1
#cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo infamous kernel p4'
echo ============================================
cd kernel
cd samsung
cd p4
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_kernel_samsung_p4_infamous.git cm-10.2
cd ../../..
#echo ============================================
#echo 'Push latest changes to beegee-tokyo vendor_n7000'
#echo ============================================
#cd vendor
#cd samsung
#cd n7000
#repo start master .
#git checkout master
#git pull
#git add -A
#git commit -a
#git push git@github.com:beegee-tokyo/android_vendor_samsung_n7000.git master
#cd ../../..
#echo ============================================
#echo 'Push latest changes to beegee-tokyo vendor_galaxys2-common'
#echo ============================================
#cd vendor
#cd samsung
#cd galaxys2-common
#repo start master .
#git checkout master
#git pull
#git add -A
#git commit -a
#git push git@github.com:beegee-tokyo/android_vendor_samsung_galaxys2-common.git master
#cd ../../..
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
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_packages_apps_Settings.git cm-10.2
cd ../../..
echo ============================================
echo 'Push latest changes to CyanogenMod framework'
echo ============================================
cd frameworks
cd base
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_frameworks_base.git cm-10.2
cd ../..
echo ============================================
echo 'Push latest changes to rom_stats'
echo ============================================
cd packages
cd apps
cd rom_stats
repo start master .
git checkout master
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/rom_stats.git master
cd ../../..
echo ============================================
echo 'Push latest changes to Ganbarou Tools'
echo ============================================
cd ganbarou_tools
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/ganbarou_tools.git cm-10.2
cd ..
echo ============================================
echo 'Push latest changes to beegee-tokyo vendor_samsung'
echo ============================================
cd vendor
cd samsung
repo start cm-10.2 .
git checkout cm-10.2
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/ganbarou_vendor_samsung.git cm-10.2
cd ../..
echo ============================================
echo 'Check output. If all ok start ./sync.sh'
echo ============================================
