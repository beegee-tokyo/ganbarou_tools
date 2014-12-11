Ganbarou Tools
======================================================================================================
*My tools and files used to build a Lollipop ROM based on Nameless sources*
------------------------------------------------------------------------------------------------------
*Credits*
------------------------------------------------------------------------------------------------------
_This ROM is build based on the [Nameless repositories](https://github.com/NamelessRom). All credits for this ROM goes to the Nameless team and kasper_h_


_This ROM uses rom-stats from [mcbyte-it](https://github.com/mcbyte-it). All credits for rom-stats goes to him._

How to build:
======================================================================================================
*Getting Started*
------------------------------------------------------------------------------------------------------

**Syncing**

To get started with Nameless ROM, you'll need to get
familiar with [Git and Repo](http://source.android.com/download/using-repo).

To initialize your local repository using the [Nameless trees](https://github.com/NamelessRom), use a command like this:

    repo init -u https://github.com/NamelessRom/android.git -b n-2.0

Then to sync up:

    repo sync -f
    
**Get my ROM specific stuff**

To prepare to build my specific ROM you need to create a folder **local_manifests** under **.repo**. Then create a file in **local_manifests** named **roomservice.xml**. Copy the content of my [roomservice.xml](https://github.com/beegee-tokyo/ganbarou_tools/blob/n-2.0/tools/roomservice.xml) into this file.

Then sync again to get my specific repositories.

    repo sync -f
    
**Preparing**

Goto **ganbarou_tools** and start **create_links.sh**. This copies the batch files, changelog and roomservice.xml to the places they are needed.

*Building*
------------------------------------------------------------------------------------------------------

Use **nameless.sh** to build the ROM. The finished ROM will be on the root of your build folder.

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

**kasper_h's work to get KitKat running on P4 devices**
**Forked repos:**
- [frameworks/av](http://github.com/beegee-tokyo/nameless_android_frameworks_av)
- [packages/apps/Settings](http://github.com/beegee-tokyo/nameless_android_packages_apps_Settings)
- [hardware/libhardware](http://github.com/beegee-tokyo/nameless_android_hardware_libhardware)
- [external/chromium_org](http://github.com/beegee-tokyo/nameless_android_external_chromium_org)
- [external/skia](http://github.com/beegee-tokyo/nameless_android_external_skia)
- [device/samsung/p4-common](http://github.com/beegee-tokyo/android_device_samsung_p4-common)
- [device/samsung/p4](http://github.com/beegee-tokyo/android_device_samsung_p4)
- [vendor/samsung/p4](http://github.com/beegee-tokyo/android_vendor_samsung_p4)
- [device/samsung/p4wifi](http://github.com/beegee-tokyo/android_device_samsung_p4wifi)
- [vendor/samsung/p4wifi](http://github.com/beegee-tokyo/android_vendor_samsung_p4wifi)

**My own repos:**
- [vendor/gapps](http://github.com/beegee-tokyo/vendor_gapps)
- [ganbarou_tools](http://github.com/beegee-tokyo/ganbarou_tools)
- [vendor/beegee](http://github.com/beegee-tokyo/android_vendor_beegee)
- [packages/apps/g_Wallpapers](http://github.com/android_packages_apps_g_Wallpapers)
- [packages/apps/rom_stats](http://github.com/beegee-tokyo/rom_stats)

*Files description*
------------------------------------------------------------------------------------------------------

**Files description:**
- nameless.sh ==> builds the ROM and makes the necessary patches (p4 for 3G ROM or p4w for Wifi ROM)
- push.sh ==> pushes changes of forked/my own repos to github
- merge.sh ==> merges changes on original repos to forked/my own repos
- sync.sh ==> synces the repos with github

**Folder description:**
- patches/data ==> additional data files for tablets & phones
- patches/datap ==> additional data files for phones only
- patches/ganbarou ==> additional system files
- patches/superuser ==> superuser files SuperSU made by Chainfire. Check XDA [thread](http://forum.xda-developers.com/showthread.php?t=1538053)
- patches/japan.apns ==> additional APNs special for Japan

