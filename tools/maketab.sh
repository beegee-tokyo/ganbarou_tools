echo ============================================
echo 'set Goo ROM version'
echo ============================================
export gooversion_t="2"
export goobuild_t="00"
export gooversion_build_t=$gooversion_t$goobuild_t
echo gooversion Tablet=$gooversion_t.$goobuild_t
echo gooversion Tablet=$gooversion_build_t
echo ============================================
echo 'Setup ccache'
echo ============================================
export USE_CCACHE=1
export CCACHE_DIR=~/.cache/.ccache
prebuilt/linux-x86/ccache/ccache -M 20G
echo ============================================
echo 'Start the build for GT-P7500'
echo ============================================
. build/envsetup.sh && brunch p4
if [ $? -eq 0 ]; then
   echo ============================================
   echo 'Build for GT-P7500 successfull'
   echo ============================================
   export P7500RESULT=0
else
   echo ============================================
   echo 'Build for GT-P7500 failed'
   echo ============================================
   export P7500RESULT=1
#   exit $?
fi
echo ============================================
echo 'Start the build for GT-P7510'
echo ============================================
. build/envsetup.sh && brunch p4wifi
if [ $? -eq 0 ]; then
   echo ============================================
   echo 'Build for GT-P7510 successfull'
   echo ============================================
   export P7510RESULT=0
else
   echo ============================================
   echo 'Build for GT-P7510 failed'
   echo ============================================
   export P7500RESULT=1
#   exit $?
fi
echo ============================================
echo 'Start the build for GT-N7000'
echo ============================================
. build/envsetup.sh && brunch n7000
if [ $? -eq 0 ]; then
   echo ============================================
   echo 'Build for GT-N7000 successfull'
   echo ============================================
   export N7000RESULT=0
else
   echo ============================================
   echo 'Build for GT-N7000 failed'
   echo ============================================
   export N7000RESULT=1
#   exit $?
fi
echo ============================================
echo 'Ganbarou patches - Set common variables'
echo ============================================
ANDROID_BUILD_TOP="/home/beegee/ganbarou_jb"
SECURITYDIR="$ANDROID_BUILD_TOP/build/target/product/security"
QUIET="-q"
NOW=$(date +"%Y-%m-%d")
NOWORG=$(date +"%Y%m%d")
SED=sed
MD5=md5sum
OUT_TARGET_HOST="linux-x86"
if [ $P7500RESULT -eq 0 ]; then
   echo ============================================
   echo 'Unpack GT-P7500 for Ganbarou patches'
   echo ============================================
   OUT="/home/beegee/ganbarou_jb/out/target/product/p4"
   REPACK="$OUT/repack.d"
   OUTFILE="$OUT/Ganbarou-GT-P7500-v$gooversion_t.$goobuild_t-$NOW.zip"
   OUTFILE1="$OUT/Ganbarou-GT-P7501-v$gooversion_t.$goobuild_t-$NOW.zip"
   OTAPACKAGE="$OUT/cm-base_for_ganbarou.zip"
   (
   mkdir $REPACK
   mkdir $REPACK/ota
   cd $REPACK/ota
   printf "Unpacking $OTAPACKAGE..."
   unzip $QUIET $OTAPACKAGE
   echo
   )
   echo ============================================
   echo 'Ganbarou changes in updater-script'
   echo ============================================
   echo ============================================
   echo 'Remove assert from updater-script'
   echo ============================================
   $SED -i \
	-e '/^a/d' \
	$REPACK/ota/META-INF/com/google/android/updater-script
   echo ============================================
   echo 'Add data extraction into updater-script'
   echo ============================================
   $SED -i \
	-e 's:package_extract_dir("system", "/system");:run_program("/sbin/busybox", "mount", "/data");package_extract_dir("system", "/system");package_extract_dir("data", "/data");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
   echo ============================================
   echo 'Add Ganbarou info into updater-script'
   echo ============================================
   $SED -i \
	-e 's:show_progress(0.500000, 0);:ui_print("Welcome to Ganbarou GT ROM");ui_print("====");ui_print("Installing system + data");show_progress(0.500000, 0);:' \
	$REPACK/ota/META-INF/com/google/android/updater-script

   $SED -i \
	-e 's:show_progress(0.100000, 0);:show_progress(0.100000, 0);ui_print("====");ui_print("All done!");ui_print("Enjoy Ganbarou GT ROM");ui_print("====");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
   echo ============================================
   echo 'Change p4 to GT-P7500 in build.prop'
   echo ============================================
   $SED -i \
   	-e 's:p4:GT-P7500:' \
	$REPACK/ota/system/build.prop
   echo ============================================
   echo 'Change ro.cm.version in build.prop'
   echo ============================================
   GANBAROU_VERSION="ro.cm.version=Ganbarou V$gooversion_t.$goobuild_t GT-P7500 CM10"
   sed -i -e 's:ro.cm.version.*::' $REPACK/ota/system/build.prop
   sed -i -e 's:ro.modversion.*::' $REPACK/ota/system/build.prop
   echo $GANBAROU_VERSION >> $REPACK/ota/system/build.prop
   echo ============================================
   echo 'Add Ganbarou tweaks to build.prop'
   echo ============================================
   echo " " >> $REPACK/ota/system/build.prop
   echo "#" >> $REPACK/ota/system/build.prop
   echo "# BeeGee_Tokyo tweaks" >> $REPACK/ota/system/build.prop
   echo "#" >> $REPACK/ota/system/build.prop
   echo "ro.HOME_APP_ADJ=1" >> $REPACK/ota/system/build.prop
   echo "debug.sf.hw=1" >> $REPACK/ota/system/build.prop
   echo "windowsmgr.max_events_per_sec=240" >> $REPACK/ota/system/build.prop
   echo "ro.telephony.call_ring.delay=0" >> $REPACK/ota/system/build.prop
   echo "wifi.supplicant_scan_interval=180" >> $REPACK/ota/system/build.prop
   echo "pm.sleep_mode=1" >> $REPACK/ota/system/build.prop
   echo "ro.ril.disable.power.collapse=0" >> $REPACK/ota/system/build.prop
   echo "mot.proximity.delay=25" >> $REPACK/ota/system/build.prop
   echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
   echo "video.accelerate.hw=1" >> $REPACK/ota/system/build.prop
   echo "ro.media.enc.jpeg.quality=100" >> $REPACK/ota/system/build.prop
   echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
   echo "ro.tether.denied=false" >> $REPACK/ota/system/build.prop
   echo "ro.media.enc.JPEG.quality=100" >> $REPACK/ota/system/build.prop
   echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
   echo "ro.max.fling_velocity=12000" >> $REPACK/ota/system/build.prop
   echo "ro.min.fling_velocity=8000" >> $REPACK/ota/system/build.prop
   echo "dalvik.vm.dexopt-flags=m=v,o=y" >> $REPACK/ota/system/build.prop
   echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
   echo "net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
   echo "net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
   echo "net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
   echo "net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
   echo "net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
   echo " " >> $REPACK/ota/system/build.prop
   echo "#" >> $REPACK/ota/system/build.prop
   echo "# Goo Manager info" >> $REPACK/ota/system/build.prop
   echo "#" >> $REPACK/ota/system/build.prop
   echo "ro.goo.developerid=beegee_tokyo" >> $REPACK/ota/system/build.prop
   echo "ro.goo.board=GT-P7500" >> $REPACK/ota/system/build.prop
   echo "ro.goo.rom=Ganbarou_GT-P7500" >> $REPACK/ota/system/build.prop
   GOO_BUILD_VERSION="ro.goo.version=$gooversion_build_t"
   echo $GOO_BUILD_VERSION >> $REPACK/ota/system/build.prop
   echo ============================================
   echo 'Put "Samsung Specific Properties" into build.prop'
   echo ============================================
   echo " " >> $REPACK/ota/system/build.prop
   echo "# Samsung Specific Properties" >> $REPACK/ota/system/build.prop
   GanbarouBuildID="ro.build.PDA=P7500JZO54K"
   echo $GanbarouBuildID >> $REPACK/ota/system/build.prop
   GanbarouBuildIDHidden="ro.build.hidden_ver=P7500JZO54K"
   echo $GanbarouBuildIDHidden >> $REPACK/ota/system/build.prop
   echo "ro.build.changelist=396106" >> $REPACK/ota/system/build.prop
   echo ============================================
   echo 'Add Ganbarou specific data files'
   echo ============================================
   mkdir $REPACK/ota/data
   mkdir $REPACK/ota/data/app
   cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/data/app/. $REPACK/ota/data/app/.
   echo ============================================
   echo 'Copy hosts, 99ganbarou and gps.conf'
   echo ============================================
   cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/gps.conf $REPACK/ota/system/etc/gps.conf
   cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/hosts $REPACK/ota/system/etc/hosts
   cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/init.d/99Ganbarou $REPACK/ota/system/etc/init.d/99Ganbarou
   echo ============================================
   echo 'Add new APN for Softbank BIZflat connection'
   echo ============================================
   $SED -i \
	-e 's:</apns>:<apn carrier="Softbank (BizFlat)" mcc="440" mnc="20" apn="bizflat.softbank" user="biz@bizflat.softbank" password="biz" type="default,supl" /></apns>': \
	$REPACK/ota/system/etc/apns-conf.xml

   echo ============================================
   echo 'Remove duplicate files for GApps'
   echo ============================================
   #rm $REPACK/ota/system/app/Gallery2.apk
   rm $REPACK/ota/system/app/Provision.apk
   rm $REPACK/ota/system/app/QuickSearchBox.apk
   rm $REPACK/ota/system/app/PlusOne.apk
   rm $REPACK/ota/system/app/Vending.apk
   echo ============================================
   echo 'Remove unwanted CM10 files'
   echo ============================================
   rm $REPACK/ota/system/app/RomManager.apk
   echo ============================================
   echo 'Add Ganbarou boot animation'
   echo ============================================
   cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/bootanimation-t/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
   echo ============================================
   echo 'Make copy of ota for GT-P7501 ROM'
   echo ============================================
   mkdir $REPACK/ota1
   cp -rf $REPACK/ota/. $REPACK/ota1/.
   echo ============================================
   echo 'Change GT-P7500 to GT-P7501 in build.prop'
   echo ============================================
   $SED -i \
   	-e 's:GT-P7500:GT-P7501:' \
	$REPACK/ota1/system/build.prop
   echo ============================================
   echo 'Zipping Ganbarou GT-P7500 ROM'
   echo ============================================
   ( cd $REPACK/ota; zip $QUIET -r $REPACK/update.zip . )
   echo ============================================
   echo 'Zipping Ganbarou GT-P7501 ROM'
   echo ============================================
   ( cd $REPACK/ota1; zip $QUIET -r $REPACK/update1.zip . )
   echo ============================================
   echo 'Sign Ganbarou GT-P7500 ROM'
   echo ============================================
   SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
   java -Xmx1024m \
   	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update.zip $OUTFILE
   echo ============================================
   echo 'Sign Ganbarou GT-P7501 ROM'
   echo ============================================
   SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
   java -Xmx1024m \
	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update1.zip $OUTFILE1
   echo ============================================
   echo 'Cleanup'
   echo ============================================
   rm -rf $REPACK
   echo ============================================
   echo 'Create a md5 checksum image of the repacked P7500 package'
   echo ============================================
   (
   img=`basename $OUTFILE`
   cd `dirname $OUTFILE`
   $MD5 $img >$img.md5sum
   )
   echo ============================================
   echo 'Create a md5 checksum image of the repacked P7501 package'
   echo ============================================
   (
   img=`basename $OUTFILE1`
   cd `dirname $OUTFILE1`
   $MD5 $img >$img.md5sum
   )
   echo ============================================
   echo "Package complete: $OUTFILE"
   echo "Package complete: $OUTFILE1"
   echo ============================================
   echo ============================================
   echo 'Copy to shared directory and cleanup'
   echo ============================================
   cp $OUTFILE ~/Windows_7/
   cp $OUTFILE.md5sum ~/Windows_7/
   cp $OUTFILE1 ~/Windows_7/
   cp $OUTFILE1.md5sum ~/Windows_7/
fi
if [ $P7510RESULT -eq 0 ]; then
echo ============================================
echo 'Unpack GT-P7510 for Ganbarou patches'
echo ============================================
OUT="/home/beegee/ganbarou_jb/out/target/product/p4wifi"
REPACK="$OUT/repack.d"
OUTFILE="$OUT/Ganbarou-GT-P7510-v$gooversion_t.$goobuild_t-$NOW.zip"
OUTFILE1="$OUT/Ganbarou-GT-P7511-v$gooversion_t.$goobuild_t-$NOW.zip"
OTAPACKAGE="$OUT/cm-base_for_ganbarou.zip"
(
mkdir $REPACK
mkdir $REPACK/ota
cd $REPACK/ota
printf "Unpacking $OTAPACKAGE..."
unzip $QUIET $OTAPACKAGE
echo
)
echo ============================================
echo 'Ganbarou changes in updater-script'
echo ============================================
echo ============================================
echo 'Remove assert from updater-script'
echo ============================================
$SED -i \
	-e '/^a/d' \
	$REPACK/ota/META-INF/com/google/android/updater-script
echo ============================================
echo 'Add data extraction into updater-script'
echo ============================================
$SED -i \
	-e 's:package_extract_dir("system", "/system");:run_program("/sbin/busybox", "mount", "/data");package_extract_dir("system", "/system");package_extract_dir("data", "/data");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
echo ============================================
echo 'Add Ganbarou info into updater-script'
echo ============================================
$SED -i \
	-e 's:show_progress(0.500000, 0);:ui_print("Welcome to Ganbarou GT ROM");ui_print("====");ui_print("Installing system + data");show_progress(0.500000, 0);:' \
	$REPACK/ota/META-INF/com/google/android/updater-script

$SED -i \
	-e 's:show_progress(0.100000, 0);:show_progress(0.100000, 0);ui_print("====");ui_print("All done!");ui_print("Enjoy Ganbarou GT ROM");ui_print("====");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
echo ============================================
echo 'Change p4wifi to GT-P7510 in build.prop'
echo ============================================
$SED -i \
	-e 's:p4wifi:GT-P7510:' \
	$REPACK/ota/system/build.prop
echo ============================================
echo 'Change ro.cm.version in build.prop'
echo ============================================
GANBAROU_VERSION="ro.cm.version=Ganbarou V$gooversion_t.$goobuild_t GT-P7510 CM10"
sed -i -e 's:ro.cm.version.*::' $REPACK/ota/system/build.prop
sed -i -e 's:ro.modversion.*::' $REPACK/ota/system/build.prop
echo $GANBAROU_VERSION >> $REPACK/ota/system/build.prop
echo ============================================
echo 'Add Ganbarou tweaks to build.prop'
echo ============================================
echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# BeeGee_Tokyo tweaks" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.HOME_APP_ADJ=1" >> $REPACK/ota/system/build.prop
echo "debug.sf.hw=1" >> $REPACK/ota/system/build.prop
echo "windowsmgr.max_events_per_sec=240" >> $REPACK/ota/system/build.prop
echo "ro.telephony.call_ring.delay=0" >> $REPACK/ota/system/build.prop
echo "wifi.supplicant_scan_interval=180" >> $REPACK/ota/system/build.prop
echo "pm.sleep_mode=1" >> $REPACK/ota/system/build.prop
echo "ro.ril.disable.power.collapse=0" >> $REPACK/ota/system/build.prop
echo "mot.proximity.delay=25" >> $REPACK/ota/system/build.prop
echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
echo "video.accelerate.hw=1" >> $REPACK/ota/system/build.prop
echo "ro.media.enc.jpeg.quality=100" >> $REPACK/ota/system/build.prop
echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
echo "ro.tether.denied=false" >> $REPACK/ota/system/build.prop
echo "ro.media.enc.JPEG.quality=100" >> $REPACK/ota/system/build.prop
echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
echo "ro.max.fling_velocity=12000" >> $REPACK/ota/system/build.prop
echo "ro.min.fling_velocity=8000" >> $REPACK/ota/system/build.prop
echo "dalvik.vm.dexopt-flags=m=v,o=y" >> $REPACK/ota/system/build.prop
echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# Goo Manager info" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.goo.developerid=beegee_tokyo" >> $REPACK/ota/system/build.prop
echo "ro.goo.board=GT-P7510" >> $REPACK/ota/system/build.prop
echo "ro.goo.rom=Ganbarou_GT-P7510" >> $REPACK/ota/system/build.prop
GOO_BUILD_VERSION="ro.goo.version=$gooversion_build_t"
echo $GOO_BUILD_VERSION >> $REPACK/ota/system/build.prop
echo ============================================
echo 'Put "Samsung Specific Properties" into build.prop'
echo ============================================
echo " " >> $REPACK/ota/system/build.prop
echo "# Samsung Specific Properties" >> $REPACK/ota/system/build.prop
   GanbarouBuildID="ro.build.PDA=P7510JZO54K"
   echo $GanbarouBuildID >> $REPACK/ota/system/build.prop
   GanbarouBuildIDHidden="ro.build.hidden_ver=P7510JZO54K"
   echo $GanbarouBuildIDHidden >> $REPACK/ota/system/build.prop
echo "ro.build.changelist=396106" >> $REPACK/ota/system/build.prop
echo ============================================
echo 'Add Ganbarou specific data files'
echo ============================================
mkdir $REPACK/ota/data
mkdir $REPACK/ota/data/app
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/data/app/. $REPACK/ota/data/app/.
echo ============================================
echo 'Copy hosts, 99ganbarou and gps.conf'
echo ============================================
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/gps.conf $REPACK/ota/system/etc/gps.conf
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/hosts $REPACK/ota/system/etc/hosts
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/init.d/99Ganbarou $REPACK/ota/system/etc/init.d/99Ganbarou
echo ============================================
echo 'Add new APN for Softbank BIZflat connection'
echo ============================================
$SED -i \
	-e 's:</apns>:<apn carrier="Softbank (BizFlat)" mcc="440" mnc="20" apn="bizflat.softbank" user="biz@bizflat.softbank" password="biz" type="default,supl" /></apns>': \
	$REPACK/ota/system/etc/apns-conf.xml

echo ============================================
echo 'Remove duplicate files for GApps'
echo ============================================
#rm $REPACK/ota/system/app/Gallery2.apk
rm $REPACK/ota/system/app/Provision.apk
rm $REPACK/ota/system/app/QuickSearchBox.apk
rm $REPACK/ota/system/app/PlusOne.apk
rm $REPACK/ota/system/app/Vending.apk
echo ============================================
echo 'Remove unwanted CM10 files'
echo ============================================
rm $REPACK/ota/system/app/RomManager.apk
echo ============================================
echo 'Add Ganbarou boot animation'
echo ============================================
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/bootanimation-t/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
echo ============================================
echo 'Make copy of ota for GT-P7511 ROM'
echo ============================================
mkdir $REPACK/ota1
cp -rf $REPACK/ota/. $REPACK/ota1/.
echo ============================================
echo 'Change GT-P7500 to GT-P7511 in build.prop'
echo ============================================
$SED -i \
	-e 's:GT-P7510:GT-P7511:' \
	$REPACK/ota1/system/build.prop
echo ============================================
echo 'Zipping Ganbarou GT-P7510 ROM'
echo ============================================
( cd $REPACK/ota; zip $QUIET -r $REPACK/update.zip . )
echo ============================================
echo 'Zipping Ganbarou GT-P7511 ROM'
echo ============================================
( cd $REPACK/ota1; zip $QUIET -r $REPACK/update1.zip . )
echo ============================================
echo 'Sign Ganbarou GT-P7510 ROM'
echo ============================================
SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
java -Xmx1024m \
	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update.zip $OUTFILE
echo ============================================
echo 'Sign Ganbarou GT-P7511 ROM'
echo ============================================
SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
java -Xmx1024m \
	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update1.zip $OUTFILE1
echo ============================================
echo 'Cleanup'
echo ============================================
rm -rf $REPACK
echo ============================================
echo 'Create a md5 checksum image of the repacked P7510 package'
echo ============================================
(
img=`basename $OUTFILE`
cd `dirname $OUTFILE`
$MD5 $img >$img.md5sum
)
echo ============================================
echo 'Create a md5 checksum image of the repacked P7511 package'
echo ============================================
(
img=`basename $OUTFILE1`
cd `dirname $OUTFILE1`
$MD5 $img >$img.md5sum
)
echo ============================================
echo "Package complete: $OUTFILE"
echo "Package complete: $OUTFILE1"
echo ============================================
echo ============================================
echo 'Copy to shared directory and cleanup'
echo ============================================
cp $OUTFILE ~/Windows_7/
cp $OUTFILE.md5sum ~/Windows_7/
cp $OUTFILE1 ~/Windows_7/
cp $OUTFILE1.md5sum ~/Windows_7/
fi
if [ $N7000RESULT -eq 0 ]; then
echo ============================================
echo 'Unpack GT-N7000 for Ganbarou patches'
echo ============================================
OUT="/home/beegee/ganbarou_jb/out/target/product/n7000"
REPACK="$OUT/repack.d"
OUTFILE="$OUT/Ganbarou-GT-N7000-v$gooversion_t.$goobuild_t-$NOW.zip"
OTAPACKAGE="$OUT/cm-base_for_ganbarou.zip"
(
mkdir $REPACK
mkdir $REPACK/ota
cd $REPACK/ota
printf "Unpacking $OTAPACKAGE..."
unzip $QUIET $OTAPACKAGE
echo
)
echo ============================================
echo 'Ganbarou changes in updater-script'
echo ============================================
echo ============================================
echo 'Add data extraction into updater-script'
echo ============================================
$SED -i \
	-e 's:package_extract_dir("system", "/system");:run_program("/sbin/busybox", "mount", "/data");package_extract_dir("system", "/system");package_extract_dir("data", "/data");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
echo ============================================
echo 'Add Ganbarou info into updater-script'
echo ============================================
$SED -i \
	-e 's:show_progress(0.500000, 0);:ui_print("Welcome to Ganbarou GT ROM");ui_print("====");ui_print("Installing system + data");show_progress(0.500000, 0);:' \
	$REPACK/ota/META-INF/com/google/android/updater-script

$SED -i \
	-e 's:show_progress(0.100000, 0);:show_progress(0.100000, 0);ui_print("====");ui_print("All done!");ui_print("Enjoy Ganbarou GT ROM");ui_print("====");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
echo ============================================
echo 'Change ro.cm.version in build.prop'
echo ============================================
GANBAROU_VERSION="ro.cm.version=Ganbarou V$gooversion_t.$goobuild_t GT-N7000 CM10"
sed -i -e 's:ro.cm.version.*::' $REPACK/ota/system/build.prop
sed -i -e 's:ro.modversion.*::' $REPACK/ota/system/build.prop
echo $GANBAROU_VERSION >> $REPACK/ota/system/build.prop
echo ============================================
echo 'Add Ganbarou tweaks to build.prop'
echo ============================================
echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# BeeGee_Tokyo tweaks" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.HOME_APP_ADJ=1" >> $REPACK/ota/system/build.prop
echo "debug.sf.hw=1" >> $REPACK/ota/system/build.prop
echo "windowsmgr.max_events_per_sec=240" >> $REPACK/ota/system/build.prop
echo "ro.telephony.call_ring.delay=0" >> $REPACK/ota/system/build.prop
echo "wifi.supplicant_scan_interval=180" >> $REPACK/ota/system/build.prop
echo "pm.sleep_mode=1" >> $REPACK/ota/system/build.prop
echo "ro.ril.disable.power.collapse=0" >> $REPACK/ota/system/build.prop
echo "mot.proximity.delay=25" >> $REPACK/ota/system/build.prop
echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
echo "video.accelerate.hw=1" >> $REPACK/ota/system/build.prop
echo "ro.media.enc.jpeg.quality=100" >> $REPACK/ota/system/build.prop
echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
echo "ro.tether.denied=false" >> $REPACK/ota/system/build.prop
echo "ro.media.enc.JPEG.quality=100" >> $REPACK/ota/system/build.prop
echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
echo "ro.max.fling_velocity=12000" >> $REPACK/ota/system/build.prop
echo "ro.min.fling_velocity=8000" >> $REPACK/ota/system/build.prop
echo "dalvik.vm.dexopt-flags=m=v,o=y" >> $REPACK/ota/system/build.prop
echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo "net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# Goo Manager info" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.goo.developerid=beegee_tokyo" >> $REPACK/ota/system/build.prop
echo "ro.goo.board=GT-N7000" >> $REPACK/ota/system/build.prop
echo "ro.goo.rom=Ganbarou_GT-N7000" >> $REPACK/ota/system/build.prop
GOO_BUILD_VERSION="ro.goo.version=$gooversion_build_p"
echo $GOO_BUILD_VERSION >> $REPACK/ota/system/build.prop
echo ============================================
echo 'Put "Samsung Specific Properties" into build.prop'
echo ============================================
echo " " >> $REPACK/ota/system/build.prop
echo "# Samsung Specific Properties" >> $REPACK/ota/system/build.prop
   GanbarouBuildID="ro.build.PDA=N7000JZO54K"
   echo $GanbarouBuildID >> $REPACK/ota/system/build.prop
   GanbarouBuildIDHidden="ro.build.hidden_ver=N7000JZO54K"
   echo $GanbarouBuildIDHidden >> $REPACK/ota/system/build.prop
echo "ro.build.changelist=396106" >> $REPACK/ota/system/build.prop
echo ============================================
echo 'Add Ganbarou specific data files'
echo ============================================
mkdir $REPACK/ota/data
mkdir $REPACK/ota/data/app
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/datap/app/. $REPACK/ota/data/app/.
echo ============================================
echo 'Add Ganbarou specific system files'
echo ============================================
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/systemapp-p/. $REPACK/ota/system/app/.
echo ============================================
echo 'Add GApps files'
echo ============================================
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/gapps-p/. $REPACK/ota/system/.
echo ============================================
echo 'Copy hosts, 99ganbarou and gps.conf'
echo ============================================
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/gps.conf $REPACK/ota/system/etc/gps.conf
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/hosts $REPACK/ota/system/etc/hosts
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/ganbarou/etc/init.d/99Ganbarou $REPACK/ota/system/etc/init.d/99Ganbarou
echo ============================================
echo 'Add new APN for Softbank BIZflat connection'
echo ============================================
$SED -i \
	-e 's:</apns>:<apn carrier="Softbank (BizFlat)" mcc="440" mnc="20" apn="bizflat.softbank" user="biz@bizflat.softbank" password="biz" type="default,supl" /></apns>': \
	$REPACK/ota/system/etc/apns-conf.xml

echo ============================================
echo 'Remove duplicate files for GApps'
echo ============================================
#rm $REPACK/ota/system/app/Gallery2.apk
rm $REPACK/ota/system/app/Provision.apk
rm $REPACK/ota/system/app/QuickSearchBox.apk
rm $REPACK/ota/system/app/PlusOne.apk
rm $REPACK/ota/system/app/Vending.apk
echo ============================================
echo 'Remove unwanted CM10 files'
echo ============================================
rm $REPACK/ota/system/app/RomManager.apk
echo ============================================
echo 'Add Ganbarou boot animation'
echo ============================================
cp -r -f -v ~beegee/ganbarou_jb/vendor/samsung/patches/bootanimation-p/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
echo ============================================
echo 'Zipping Ganbarou GT-N7000 ROM'
echo ============================================
( cd $REPACK/ota; zip $QUIET -r $REPACK/update.zip . )
echo ============================================
echo 'Sign Ganbarou GT-N7000 ROM'
echo ============================================
SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
java -Xmx1024m \
	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update.zip $OUTFILE
echo ============================================
echo 'Cleanup'
echo ============================================
rm -rf $REPACK
echo ============================================
echo 'Create a md5 checksum image of the repacked N7000 package'
echo ============================================
(
img=`basename $OUTFILE`
cd `dirname $OUTFILE`
$MD5 $img >$img.md5sum
)
echo ============================================
echo "Package complete: $OUTFILE"
echo ============================================
echo ============================================
echo 'Copy to shared directory and cleanup'
echo ============================================
cp $OUTFILE ~/Windows_7/
cp $OUTFILE.md5sum ~/Windows_7/
fi
echo ============================================
echo 'Build & Patch of Ganbarou ROM done'
echo ============================================
echo gooversion Tablet=$gooversion_t.$goobuild_t
echo gooversion Tablet=$gooversion_build_t
if [ $P7500RESULT -eq 0 ]; then
   echo ============================================
   echo 'Build for GT-P7500/7501 done'
   echo ============================================
else
   echo ============================================
   echo 'Build for GT-P7500/7501 failed'
   echo ============================================
fi
if [ $P7510RESULT -eq 0 ]; then
   echo ============================================
   echo 'Build for GT-P7510/7511 done'
   echo ============================================
else
   echo ============================================
   echo 'Build for GT-P7510/7511 failed'
   echo ============================================
fi
if [ $N7000RESULT -eq 0 ]; then
   echo ============================================
   echo 'Build for GT-N7000 done'
   echo ============================================
else
   echo ============================================
   echo 'Build for GT-N7000 failed'
   echo ============================================
fi
