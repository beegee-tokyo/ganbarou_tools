Ganbarou Tools
======================================================================================================
*My tools and files used to build an AOSP based ROM*
------------------------------------------------------------------------------------------------------
*Credits*
------------------------------------------------------------------------------------------------------
_This ROM is build based on the [repositories](https://github.com/AOSP-S4-KK) of [broodplank](https://github.com/broodplank). All credits for the basics of this ROM goes to him_

_This ROM uses ChainFire [SuperSU](http://forum.xda-developers.com/showthread.php?t=1538053). All credits for the su functionality goes to him_

_This ROM uses rom-stats from [mcbyte-it](https://github.com/mcbyte-it). All credits for rom-stats goes to him._

How to build:
======================================================================================================
*Getting Started*
------------------------------------------------------------------------------------------------------

**Syncing**

To get started with AOSP ROM, you'll need to get
familiar with [Git and Repo](http://source.android.com/download/using-repo).

To initialize your local repository using the [AOSP-S4-KK trees](https://github.com/AOSP-S4-KK), use a command like this:

    repo init -u git://github.com/AOSP-S4-KK/platform_manifest -b kk-4.4

Then to sync up:

    repo sync -f
    
**Get my ROM specific stuff**

To prepare to build my specific ROM you need to create a folder **local_manifests** under **.repo**. Then create a file in **local_manifests** named **roomservice.xml**. Copy the content of my [roomservice.xml](https://github.com/beegee-tokyo/ganbarou_tools/blob/kk-4.4/tools/roomservice.xml) into this file.

Then sync again to get my specific repositories.

    repo sync -f
    
**Preparing**

Goto **ganbarou_tools** and start **create_links.sh**. This copies the batch files, changelog and roomservice.xml to the places they are needed.

*Building*
------------------------------------------------------------------------------------------------------

Use **builds4.sh** to build the ROM. The finished ROM will be on the root of your build folder.

*Updating the sources*
------------------------------------------------------------------------------------------------------

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
- [device/samsung/jflte](http://github.com/beegee-tokyo/platform_device_samsung_jflte)

**My own repos:**
- [vendor/gapps](http://github.com/beegee-tokyo/vendor_gapps)
- [ganbarou_tools](http://github.com/beegee-tokyo/ganbarou_tools)
- [vendor/beegee](http://github.com/beegee-tokyo/android_vendor_beegee)
- [packages/apps/g_Wallpapers](http://github.com/android_packages_apps_g_Wallpapers)
- [packages/apps/rom_stats](http://github.com/beegee-tokyo/rom_stats)

*Files description*
------------------------------------------------------------------------------------------------------

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

