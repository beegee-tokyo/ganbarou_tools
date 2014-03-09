Ganbarou Tools
======================================================================================================
*My tools and files used to build an AOSP based ROM*
------------------------------------------------------------------------------------------------------
**Initialize tools:**
Use create_links.sh to copy batches, changelog and rommservice.xml to the folders they are needed.

**Files description:**
- builds4.sh ==> builds the ROM and makes the necessary patches
- justs4.sh ==> just makes the patches to the ROM
- push.sh ==> pushes changes of forked/my own repos to github
- merge.sh ==> merges changes on original repos to forked/my own repos
- sync.sh ==> synces the repos with github

**Folder description:**
- patches/data ==> additional data files for tablets & phones
- patches/datap ==> additional data files for phones only
- patches/ganbarou ==> additional system files
- patches/superuser ==> superuser files SuperSU made by Chainfire. Check XDA [thread](http://forum.xda-developers.com/showthread.php?t=1538053)
- patches/japan.apns ==> additional APNs special for Japan

**Steps for updates after changes in the local repos are done:**

1. push.sh
2. sync.sh
3. merge.sh
4. push.sh
5. sync.sh

**Steps for updates without changes in the local repos:**

1. merge.sh
2. push.sh
3. sync.sh

**Forked repos:**
- [frameworks/base](http://github.com/beegee-tokyo/platform_frameworks_base)
- [packages/apps/Settings](http://github.com/beegee-tokyo/platform_packages_apps_settings)
- [build](http://github.com/beegee-tokyo/android_build)

**My own repos:**
- [vendor/gapps](http://github.com/beegee-tokyo/vendor_gapps)
- [ganbarou_tools](http://github.com/beegee-tokyo/ganbarou_tools)
- [vendor/beegee](http://github.com/beegee-tokyo/android_vendor_beegee)
- [packages/apps/g_Wallpapers](http://github.com/android_packages_apps_g_Wallpapers)
- [packages/apps/rom_stats](http://github.com/beegee-tokyo/rom_stats)

