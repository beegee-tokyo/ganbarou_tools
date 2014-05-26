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
echo 'Get latest changes from build'
echo ============================================
cd build
git checkout kk-4.4
git remote add upstream git://github.com/AOSP-S4-KK/platform_build.git
git fetch upstream
git merge upstream/kk-4.4
cd ..
echo ============================================
echo 'Check output. If all ok start ./push.sh'
echo ============================================

