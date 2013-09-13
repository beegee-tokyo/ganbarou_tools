_CURRENTPATH=${PWD##*/}
echo ============================================
echo 'Clean up directories from tmp files'
echo ============================================
cd ../
find ./$_CURRENTPATH -name *.*~ -exec rm -rf {} \;
cd $_CURRENTPATH
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
echo 'Check output. If all ok start ./sync.sh'
echo ============================================
