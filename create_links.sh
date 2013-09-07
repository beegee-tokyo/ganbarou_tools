ln -f -v ./tools/changelog.txt ../changelog.txt
ln -f -v ./tools/locsync.sh ../locsync.sh
ln -f -v ./tools/makeit.sh ../makeit.sh
ln -f -v ./tools/merge.sh ../merge.sh
ln -f -v ./tools/patchit.sh ../patchit.sh
ln -f -v ./tools/push.sh ../push.sh
ln -f -v ./tools/pushtools.sh ../pushtools.sh
ln -f -v ./tools/sync.sh ../sync.sh
ln -f -v ./tools/roomservice.xml ../.repo/local_manifests/roomservice.xml

# test: create links in /sdk/platform-tools to start them without an leading ./
ln -f -v ./tools/makeit.sh ~/sdk/platform-tools/makeit.sh
ln -f -v ./tools/merge.sh ~/sdk/platform-tools/merge.sh
ln -f -v ./tools/patchit.sh ~/sdk/platform-tools/patchit.sh
ln -f -v ./tools/push.sh ~/sdk/platform-tools/push.sh
ln -f -v ./tools/pushtools.sh ~/sdk/platform-tools/pushtools.sh
ln -f -v ./tools/sync.sh ~/sdk/platform-tools/sync.sh
