echo ============================================
echo 'Push latest changes to beegee-tokyo frameworks_base'
echo ============================================
cd frameworks
cd base
repo start kk-4.4 .
git checkout kk-4.4
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/platform_frameworks_base.git kk-4.4
cd ../..
echo ============================================
echo 'Push latest changes to beegee-tokyo settings'
echo ============================================
cd packages
cd apps
cd Settings
repo start kk-4.4 .
git checkout kk-4.4
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/platform_packages_apps_settings.git kk-4.4
cd ../../..
echo ============================================
echo 'Push latest changes to beegee-tokyo vendor_gapps'
echo ============================================
cd vendor
cd gapps
repo start android-4.4-core .
git checkout android-4.4-core
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/vendor_gapps.git android-4.4-core
cd ../..
echo ============================================
echo 'Push latest changes to beegee-tokyo ganbarou_tools'
echo ============================================
cd ganbarou_tools
repo start kk-4.4 .
git checkout kk-4.4
git pull
git add -A
git commit -a
git push git@github.com:beegee-tokyo/ganbarou_tools.git kk-4.4
cd ..
echo ============================================
echo 'Check output. If all ok start ./sync.sh'
echo ============================================
