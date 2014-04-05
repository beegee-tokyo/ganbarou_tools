echo ============================================
echo 'Get latest changes from framework'
echo ============================================
cd frameworks
cd base
git checkout kk-4.4
git remote add upstream git://github.com/AOSP-S4-KK/platform_frameworks_base.git
git fetch upstream
git merge upstream/kk-4.4
cd ../..
echo ============================================
echo 'Get latest changes from settings'
echo ============================================
cd packages
cd apps
cd Settings
git checkout kk-4.4
git remote add upstream git://github.com/AOSP-S4-KK/platform_packages_apps_settings.git
git fetch upstream
git merge upstream/kk-4.4
cd ../../..
echo ============================================
echo 'Get latest changes from vendor'
echo ============================================
cd vendor
cd samsung
git checkout kk-4.4
git remote add upstream git://github.com/AOSP-S4-KK/platform_vendor_samsung.git
git fetch upstream
git merge upstream/kk-4.4
cd ../..
echo ============================================
echo 'Get latest changes from device'
echo ============================================
cd device
cd samsung
cd jflte
git checkout kk-4.4
git remote add upstream git://github.com/AOSP-S4-KK/platform_device_samsung_jflte.git
git fetch upstream
git merge upstream/kk-4.4
cd ../../..
echo ============================================
echo 'Get latest changes from platform_kernel_samsung_jf'
echo ============================================
cd kernel
cd samsung
cd jf
git checkout kk-4.4_new
it remote add upstream git://github.com/AOSP-S4-KK/platform_kernel_samsung_jf.git
git fetch upstream
git merge upstream/kk-4.4_new
cd ../../..
echo ============================================
echo 'Check output. If all ok start ./push.sh'
echo ============================================

