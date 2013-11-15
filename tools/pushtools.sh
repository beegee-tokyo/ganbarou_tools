echo ============================================
echo 'Copy batch files back to Ganbarou Tools'
echo ============================================
cp changelog.txt ./ganbarou_tools/tools/changelog.txt
cp makeit.sh ./ganbarou_tools/tools/makeit.sh 
cp merge.sh ./ganbarou_tools/tools/merge.sh 
cp patchit.sh ./ganbarou_tools/tools/patchit.sh 
cp publish.sh ./ganbarou_tools/tools/publish.sh 
cp push.sh ./ganbarou_tools/tools/push.sh 
cp pushtools.sh ./ganbarou_tools/tools/pushtools.sh 
cp sync.sh ./ganbarou_tools/tools/sync.sh 
cp ./.repo/local_manifests/roomservice.xml ./ganbarou_tools/tools/roomservice.xml 
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
