# $NEW_DEVICE = GT-P7500 or GT-P7510 or GT-N7000
# $NEW_DEVICE1 = GT-P7501 or GT-P7511
# $NEW_DEVICE2 = 1 for P7501/P7511 and 0 for N7000
# $OLD_DEVICE = p4 or p4wifi or n7000
NEW_DEVICE=$1
NEW_DEVICE1=$2
NEW_DEVICE2=$3
OLD_DEVICE=$4
echo NEW_DEVICE = $NEW_DEVICE
echo NEW_DEVICE1 = $NEW_DEVICE1
echo NEW_DEVICE2 = $NEW_DEVICE2
echo OLD_DEVICE = $OLD_DEVICE
echo ============================================
echo "Ganbarou patches - Set common variables"
echo ============================================
ANDROID_BUILD_TOP="/home/$USER/${PWD##*/}"
echo $ANDROID_BUILD_TOP
SECURITYDIR="$ANDROID_BUILD_TOP/build/target/product/security"
QUIET="-q"
NOW=$(date +"%Y-%m-%d")
NOWORG=$(date +"%Y%m%d")
SED=sed
MD5=md5sum
OUT_TARGET_HOST="linux-x86"

echo ============================================
echo "Unpack $NEW_DEVICE for Ganbarou patches"
echo ============================================
OUT="$ANDROID_BUILD_TOP/out/target/product/$OLD_DEVICE"
REPACK="$OUT/repack.d"
OUTFILE="$OUT/Ganbarou-$NEW_DEVICE-v$gooversion_t.$goobuild_t-$NOW.zip"
if [ $NEW_DEVICE2 -eq 1 ]; then
   OUTFILE1="$OUT/Ganbarou-$NEW_DEVICE1-v$gooversion_t.$goobuild_t-$NOW.zip"
fi
OTAPACKAGE="$OUT/cm-base_for_ganbarou.zip"
mkdir $REPACK
mkdir $REPACK/ota
cd $REPACK/ota
printf "Unpacking $OTAPACKAGE..."
unzip $QUIET $OTAPACKAGE
echo
echo ============================================
echo "Ganbarou changes in updater-script"
echo ============================================
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo ============================================
   echo "Remove assert from updater-script"
   echo ============================================
   $SED -i \
	-e '/^a/d' \
	$REPACK/ota/META-INF/com/google/android/updater-script
fi
echo ============================================
echo "Add data extraction into updater-script"
echo ============================================
$SED -i \
	-e 's:package_extract_dir("system", "/system");:run_program("/sbin/busybox", "mount", "/data");package_extract_dir("system", "/system");package_extract_dir("data", "/data");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
echo ============================================
echo "Add Ganbarou info into updater-script"
echo ============================================
$SED -i \
	-e 's:show_progress(0.500000, 0);:ui_print(" ");ui_print(" ");ui_print(" ");ui_print("Welcome to Ganbarou GT ROM");ui_print("=========================");ui_print("Installing system + data");show_progress(0.500000, 0);:' \
	$REPACK/ota/META-INF/com/google/android/updater-script

$SED -i \
	-e 's:show_progress(0.100000, 0);:show_progress(0.100000, 0);ui_print("=========================");ui_print("All done!");ui_print("Enjoy Ganbarou GT ROM");ui_print("=========================");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo ============================================
   echo "Change $OLD_DEVICE to $NEW_DEVICE in build.prop"
   echo ============================================
   $SED -i \
   	-e "s:${OLD_DEVICE}:${NEW_DEVICE}:" \
	$REPACK/ota/system/build.prop
fi
echo ============================================
echo "Change ro.cm.version in build.prop"
echo ============================================
GANBAROU_VERSION="ro.cm.version=Ganbarou V$gooversion_t.$goobuild_t $NEW_DEVICE"
sed -i -e 's:ro.cm.version.*::' $REPACK/ota/system/build.prop
sed -i -e 's:ro.modversion.*::' $REPACK/ota/system/build.prop
echo $GANBAROU_VERSION >> $REPACK/ota/system/build.prop
echo ============================================
echo "Change ro.build.display.id in build.prop"
echo ============================================
$SED -i \
   	-e 's:ro.build.display.id=cm_:ro.build.display.id=Ganbarou_:' \
	$REPACK/ota/system/build.prop
echo ============================================
echo "Add Ganbarou tweaks to build.prop"
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
RO_GOO_BOARD="ro.goo.board=$NEW_DEVICE"
echo $RO_GOO_BOARD >> $REPACK/ota/system/build.prop
RO_GOO_ROM="ro.goo.rom=Ganbarou_$NEW_DEVICE"
echo $RO_GOO_ROM >> $REPACK/ota/system/build.prop
GOO_BUILD_VERSION="ro.goo.version=$gooversion_build_t"
echo $GOO_BUILD_VERSION >> $REPACK/ota/system/build.prop
#echo ============================================
#echo "Put Samsung Specific Properties into build.prop"
#echo ============================================
#echo " " >> $REPACK/ota/system/build.prop
#echo "# Samsung Specific Properties" >> $REPACK/ota/system/build.prop
#NEW_DEVICE_SHORT=$NEW_DEVICE | cut -c4-8
#NEW_BUILD_ID="JZO54K"
#GanbarouBuildID="ro.build.PDA=$NEW_DEVICE_SHORT$BUILD_ID"
#echo $GanbarouBuildID >> $REPACK/ota/system/build.prop
#GanbarouBuildIDHidden="ro.build.hidden_ver=$NEW_DEVICE_SHORT$BUILD_ID"
#echo $GanbarouBuildIDHidden >> $REPACK/ota/system/build.prop
#echo "ro.build.changelist=396106" >> $REPACK/ota/system/build.prop
echo ============================================
echo "Add Ganbarou specific data files"
echo ============================================
mkdir $REPACK/ota/data
mkdir $REPACK/ota/data/app
if [ $NEW_DEVICE2 -eq 1 ]; then
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/data/app/. $REPACK/ota/data/app/.
else
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/datap/app/. $REPACK/ota/data/app/.
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/systemapp-p/. $REPACK/ota/system/app/.
fi
echo ============================================
echo "Copy hosts, 99ganbarou and gps.conf"
echo ============================================
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/gps.conf $REPACK/ota/system/etc/gps.conf
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/hosts $REPACK/ota/system/etc/hosts
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/init.d/99Ganbarou $REPACK/ota/system/etc/init.d/99Ganbarou
echo ============================================
echo "Add new APN for Softbank BIZflat connection"
echo ============================================
$SED -i \
	-e 's:</apns>:<apn carrier="Softbank (BizFlat)" mcc="440" mnc="20" apn="bizflat.softbank" user="biz@bizflat.softbank" password="biz" type="default,supl" /></apns>': \
	$REPACK/ota/system/etc/apns-conf.xml

echo ============================================
echo "Remove duplicate files for GApps"
echo ============================================
#rm $REPACK/ota/system/app/Gallery2.apk
rm $REPACK/ota/system/app/Provision.apk
rm $REPACK/ota/system/app/QuickSearchBox.apk
rm $REPACK/ota/system/app/PlusOne.apk
rm $REPACK/ota/system/app/Vending.apk
echo ============================================
echo "Remove unwanted CM10 files"
echo ============================================
rm $REPACK/ota/system/app/RomManager.apk
echo ============================================
echo "Add Ganbarou boot animation"
echo ============================================
if [ $NEW_DEVICE2 -eq 1 ]; then
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/bootanimation-t/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
else
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/bootanimation-p/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
fi
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo ============================================
   echo "Make copy of ota for $NEW_DEVICE1 ROM"
   echo ============================================
   mkdir $REPACK/ota1
   cp -rf $REPACK/ota/. $REPACK/ota1/.
   echo ============================================
   echo "Change $NEW_DEVICE to $NEW_DEVICE1 in build.prop"
   echo ============================================
   $SED -i \
   	-e "s:${NEW_DEVICE}:${NEW_DEVICE1}:" \
	$REPACK/ota1/system/build.prop
fi
echo ============================================
echo "Zipping Ganbarou $NEW_DEVICE ROM"
echo ============================================
( cd $REPACK/ota; zip $QUIET -r $REPACK/update.zip . )
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo ============================================
   echo "Zipping Ganbarou $NEW_DEVICE1 ROM"
   echo ============================================
   ( cd $REPACK/ota1; zip $QUIET -r $REPACK/update1.zip . )
fi
echo ============================================
echo "Sign Ganbarou $NEW_DEVICE ROM"
echo ============================================
SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
   java -Xmx1024m \
   	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update.zip $OUTFILE
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo ============================================
   echo "Sign Ganbarou $NEW_DEVICE1 ROM"
   echo ============================================
   SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
   java -Xmx1024m \
	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update1.zip $OUTFILE1
fi
echo ============================================
echo "Cleanup"
echo ============================================
rm -rf $REPACK
echo ============================================
echo "Create a md5 checksum image of the repacked $NEW_DEVICE package"
echo ============================================
(
img=`basename $OUTFILE`
cd `dirname $OUTFILE`
$MD5 $img >$img.md5sum
)
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo ============================================
   echo "Create a md5 checksum image of the repacked $NEW_DEVICE1 package"
   echo ============================================
   (
   img=`basename $OUTFILE1`
   cd `dirname $OUTFILE1`
   $MD5 $img >$img.md5sum
   )
fi
echo ============================================
echo "Package complete: $OUTFILE"
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo "Package complete: $OUTFILE1"
fi
echo ============================================
echo ============================================
echo "Copy to shared directory and cleanup"
echo ============================================
mv $OUTFILE $ANDROID_BUILD_TOP/
mv $OUTFILE.md5sum $ANDROID_BUILD_TOP/
if [ $NEW_DEVICE2 -eq 1 ]; then
   mv $OUTFILE1 $ANDROID_BUILD_TOP/
   mv $OUTFILE1.md5sum $ANDROID_BUILD_TOP/
fi

