echo ============================================
echo 'Get latest changes to beegee-tokyo/android_device_samsung_p4-common'
echo ============================================
cd device/samsung/p4-common
git checkout nameless
git remote add upstream git://github.com/kasperhettinga/android_device_samsung_p4-common.git 
git fetch upstream
git merge upstream/nameless
cd ../../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/android_device_samsung_p4'
echo ============================================
cd device/samsung/p4
git checkout nameless
git remote add upstream git://github.com/kasperhettinga/android_device_samsung_p4.git 
git fetch upstream
git merge upstream/nameless
cd ../../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/android_vendor_samsung_p4'
echo ============================================
cd vendor/samsung/p4
git checkout nameless
git remote add upstream git://github.com/kasperhettinga/android_vendor_samsung_p4.git 
git fetch upstream
git merge upstream/nameless
cd ../../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/android_device_samsung_p4wifi'
echo ============================================
cd device/samsung/p4wifi
git checkout nameless
git remote add upstream git://github.com/kasperhettinga/android_device_samsung_p4wifi 
git fetch upstream
git merge upstream/nameless
cd ../../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/android_vendor_samsung_p4wifi'
echo ============================================
cd vendor/samsung/p4wifi
git checkout nameless
git remote add upstream git://github.com/kasperhettinga/android_vendor_samsung_p4wifi.git 
git fetch upstream
git merge upstream/nameless
cd ../../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/nameless_android_frameworks_av'
echo ============================================
cd frameworks/av
git checkout android-4.4
git remote add upstream git://github.com/NamelessRom/android_frameworks_av.git 
git fetch upstream
git merge upstream/android-4.4
cd ../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/nameless_android_frameworks_base'
echo ============================================
cd frameworks/base
git checkout android-4.4
git remote add upstream git://github.com/NamelessRom/android_frameworks_base.git 
git fetch upstream
git merge upstream/android-4.4
cd ../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/nameless_android_packages_apps_Settings'
echo ============================================
cd packages/apps/Settings
git checkout android-4.4
git remote add upstream git://github.com/NamelessRom/android_packages_apps_Settings.git 
git fetch upstream
git merge upstream/android-4.4
cd ../../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/nameless_android_hardware_libhardware'
echo ============================================
cd hardware/libhardware
git checkout cm-11.0
git remote add upstream git://github.com/CyanogenMod/android_hardware_libhardware.git 
git fetch upstream
git merge upstream/cm-11.0
cd ../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/nameless_android_external_skia'
echo ============================================
cd external/skia
git checkout cm-11.0
git remote add upstream git://github.com/CyanogenMod/android_external_skia.git 
git fetch upstream
git merge upstream/cm-11.0
cd ../..
echo ============================================
echo 'Get latest changes to beegee-tokyo/nameless_android_bionic'
echo ============================================
cd bionic
git checkout android-4.4
git remote add upstream git://github.com/NamelessRom/android_bionic.git 
git fetch upstream
git merge upstream/android-4.4
cd ..
echo ============================================
echo 'Check output. If all ok start ./push.sh'
echo ============================================
