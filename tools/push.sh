echo ============================================
echo 'Push latest changes to beegee-tokyo/android_device_samsung_p4-common'
echo ============================================
cd device/samsung/p4-common
repo start nameless .
git checkout nameless
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4-common.git nameless
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/android_device_samsung_p4'
echo ============================================
cd device/samsung/p4
repo start nameless .
git checkout nameless
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4.git nameless
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/android_vendor_samsung_p4'
echo ============================================
cd vendor/samsung/p4
repo start nameless .
git checkout nameless
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_vendor_samsung_p4.git nameless
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/android_device_samsung_p4wifi'
echo ============================================
cd device/samsung/p4wifi
repo start nameless .
git checkout nameless
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_device_samsung_p4wifi nameless
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/android_vendor_samsung_p4wifi'
echo ============================================
cd vendor/samsung/p4wifi
repo start nameless .
git checkout nameless
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/android_vendor_samsung_p4wifi.git nameless
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/nameless_android_frameworks_base'
echo ============================================
cd frameworks/base
repo start android-4.4 .
git checkout android-4.4
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/nameless_android_frameworks_base.git android-4.4
cd ../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/nameless_android_packages_apps_Settings'
echo ============================================
cd packages/apps/Settings
repo start android-4.4 .
git checkout android-4.4
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/nameless_android_packages_apps_Settings.git android-4.4
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo/ganbarou_tools'
echo ============================================
cd ganbarou_tools
repo start nameless .
git checkout nameless
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/ganbarou_tools.git nameless
cd ..
echo ============================================
echo 'Check output. If all ok start ./sync.sh'
echo ============================================
