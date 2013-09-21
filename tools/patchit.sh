# $NEW_DEVICE = GT-P7500 or GT-P7510 or GT-N7000
# $NEW_DEVICE1 = GT-P7501 or GT-P7511
# $NEW_DEVICE2 = 1 for P7501/P7511 and 0 for N7000
# $OLD_DEVICE = p4 or p4wifi or n7000
# KERNEL_VERSION = infamous or pershoot
# TEST_BUILD = 1 if quick build only for P7500 else it is 0

NEW_DEVICE=$1
NEW_DEVICE1=$2
NEW_DEVICE2=$3
OLD_DEVICE=$4
KERNEL_VERSION=$5
TEST_BUILD=$6
# build with colors!
CL_RED="\033[31m"
CL_GRN="\033[32m"
CL_YLW="\033[33m"
CL_BLU="\033[34m"
CL_MAG="\033[35m"
CL_CYN="\033[36m"
CL_RST="\033[0m"
echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Building :"$CL_RST
echo -e $CL_GRN"============================================"$CL_RST

echo -e $CL_MAG"NEW_DEVICE = "$CL_YLW"$NEW_DEVICE"$CL_RST
echo -e $CL_MAG"NEW_DEVICE1 = "$CL_YLW"$NEW_DEVICE1"$CL_RST
echo -e $CL_MAG"NEW_DEVICE2 = "$CL_YLW"$NEW_DEVICE2"$CL_RST
echo -e $CL_MAG"OLD_DEVICE = "$CL_YLW"$OLD_DEVICE"$CL_RST
echo -e $CL_MAG"KERNEL_VERSION = "$CL_YLW"$KERNEL_VERSION"$CL_RST
echo -e $CL_MAG"TEST_BUILD = "$CL_YLW"$TEST_BUILD"$CL_RST
echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Ganbarou patches - Set common variables"$CL_RST
echo -e $CL_GRN"============================================"$CL_RST
ANDROID_BUILD_TOP="/home/$USEROLD/${PWD##*/}"
echo $ANDROID_BUILD_TOP
SECURITYDIR="$ANDROID_BUILD_TOP/build/target/product/security"
QUIET="-q"
NOW=$(date +"%Y-%m-%d")
NOWORG=$(date +"%Y%m%d")
SED=sed
MD5=md5sum
OUT_TARGET_HOST="linux-x86"

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Unpack $NEW_DEVICE for Ganbarou patches"
echo -e $CL_GRN"============================================"$CL_RST
OUT="$ANDROID_BUILD_TOP/out/target/product/$OLD_DEVICE"
REPACK="$OUT/repack.d"
# for the moment we build only with one kernel version
#OUTFILE="$OUT/Ganbarou-$NEW_DEVICE-v$gooversion_t.$goobuild_t-$NOW-$KERNEL_VERSION.zip"
#if [ $NEW_DEVICE2 -eq 1 ]; then
#   OUTFILE1="$OUT/Ganbarou-$NEW_DEVICE1-v$gooversion_t.$goobuild_t-$NOW-$KERNEL_VERSION.zip"
#fi
OUTFILE="$OUT/Ganbarou-$NEW_DEVICE-v$gooversion_t.$goobuild_t-$NOW.zip"
DEVICE_VERSION="ui_print(\"Version $gooversion_t.$goobuild_t\");"
DEVICE_INFO="ui_print(\"for $NEW_DEVICE\");"
if [ $NEW_DEVICE2 -eq 1 ]; then
   OUTFILE1="$OUT/Ganbarou-$NEW_DEVICE1-v$gooversion_t.$goobuild_t-$NOW.zip"
   DEVICE_INFO1="ui_print(\"for $NEW_DEVICE1\");"
fi
# was cm-base_for_ganbarou.zip is now cm_p4-ota-eng.beegee.zip p4 can be p4wifi or n7000
#OTAPACKAGE="$OUT/cm-10.2-$NOWORG-UNOFFICIAL-$OLD_DEVICE.zip"
OTAPACKAGE="$OUT/cm_$OLD_DEVICE-ota-eng.$USER.zip"
mkdir $REPACK
mkdir $REPACK/ota
cd $REPACK/ota
printf "Unpacking $OTAPACKAGE..."
unzip $QUIET $OTAPACKAGE
echo $DEVICE_VERSION
echo $DEVICE_INFO
echo $DEVICE_INFO1

# IF we build for infamous kernel then we have to change $OLD_DEVICE
export OLD_DEVICE2=$OLD_DEVICE
if [[ $OLD_DEVICE == p4p ]]; then 
   export OLD_DEVICE2="p4"
fi
if [[ $OLD_DEVICE == p4wifip ]]; then 
   export OLD_DEVICE2="p4wifi"
fi

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Ganbarou changes in updater-script"
echo -e $CL_GRN"============================================"$CL_RST
#if [ $NEW_DEVICE2 -eq 1 ] || [ $TEST_BUILD -eq 1 ] ; then
if [ $NEW_DEVICE != "GT-I9505" ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Remove assert from updater-script"
   if [ $NEW_DEVICE != "GT-N7000" ]; then
   echo -e $CL_GRN"for tablet"
    $SED -i \
	-e '/^a/d' \
	$REPACK/ota/META-INF/com/google/android/updater-script
   fi
   if [ $NEW_DEVICE == "GT-N7000" ]; then
   echo -e $CL_GRN"for GT-N7000"
    $SED -i '1,4d' $REPACK/ota/META-INF/com/google/android/updater-script
   fi
   echo -e $CL_GRN"============================================"$CL_RST
fi
echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"clean-up updater-script"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
	-e 's:show_progress(0.200000, 0);::' \
	$REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
	-e 's:show_progress(0.200000, 10);::' \
	$REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
	-e 's:show_progress(0.500000, 0);::' \
	$REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
	'/^$/d' \
	$REPACK/ota/META-INF/com/google/android/updater-script

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add data extraction into updater-script"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
	-e 's:package_extract_dir("system", "/system");:run_program("/sbin/busybox", "mount", "/data");package_extract_dir("system", "/system");package_extract_dir("data", "/data");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Ganbarou info into updater-script"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
        '1i show_progress(0.5, 60);' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print("Installing system + data");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print("=============================");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        "1i ${DEVICE_INFO}" $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        "1i ${DEVICE_VERSION}" $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print("=============================");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print("Welcome to Ganbarou GT ROM");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print("=============================");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print(" ");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print(" ");' $REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
        '1i ui_print(" ");' $REPACK/ota/META-INF/com/google/android/updater-script
if [ $NEW_DEVICE != "GT-N7000" ]; then
  $SED -i \
	'/package_extract_file("boot.img"/i \
	ui_print("=============================");ui_print("Flashing kernel");' \
	$REPACK/ota/META-INF/com/google/android/updater-script
fi
if [ $NEW_DEVICE == "GT-N7000" ]; then
  $SED -i \
	'/assert(package_extract_file("boot.img"/i \
	ui_print("=============================");ui_print("Flashing kernel");' \
	$REPACK/ota/META-INF/com/google/android/updater-script
fi
$SED -i \
	-e 's:show_progress(0.100000, 0);:show_progress(1.000000, 30);run_program("/sbin/rm", "-rf", "/data/data/android.romstats");ui_print("=============================");ui_print("All done!");ui_print("Enjoy Ganbarou GT ROM");ui_print("=============================");:' \
	$REPACK/ota/META-INF/com/google/android/updater-script

#if [ $NEW_DEVICE2 -eq 1 ] || [ $TEST_BUILD -eq 1 ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Change $OLD_DEVICE to $NEW_DEVICE in build.prop"
   echo -e $CL_GRN"But keep ro.product.device for Google Play"
   echo -e $CL_GRN"============================================"$CL_RST
   $SED -i \
   	-e "s:${OLD_DEVICE}:${NEW_DEVICE}:" \
	$REPACK/ota/system/build.prop
   OLD_PROD_DEV="ro.product.device=$NEW_DEVICE"
   NEW_PROD_DEV="ro.product.device=$OLD_DEVICE2"
   $SED -i \
   	-e "s:${OLD_PROD_DEV}:${NEW_PROD_DEV}:" \
	$REPACK/ota/system/build.prop
#fi
echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Change ro.cm.version in build.prop"
echo -e $CL_GRN"============================================"$CL_RST
GANBAROU_VERSION="ro.cm.version=Ganbarou V$gooversion_t.$goobuild_t $NEW_DEVICE"
sed -i -e 's:ro.cm.version.*::' $REPACK/ota/system/build.prop
sed -i -e 's:ro.modversion.*::' $REPACK/ota/system/build.prop
echo $GANBAROU_VERSION >> $REPACK/ota/system/build.prop

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Change ro.build.display.id in build.prop"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
   	-e 's:ro.build.display.id=cm_:ro.build.display.id=Ganbarou_:' \
	$REPACK/ota/system/build.prop

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Ganbarou tweaks to build.prop"
echo -e $CL_GRN"============================================"$CL_RST
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
echo "ro.secure=0" >> $REPACK/ota/system/build.prop
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
#if [ $NEW_DEVICE == "GT-P7500" ] || [ $NEW_DEVICE == "GT-P7510" ]; then
#   echo "tablet.mode=1" >> $REPACK/ota/system/build.prop
#else
#   echo "tablet.mode=0" >> $REPACK/ota/system/build.prop
#fi
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
echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# ROM Statistics and ROM Identification" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.romstats.url=http://www.desire.giesecke.tk/romstats/" >> $REPACK/ota/system/build.prop
ROMSTATS_NAME="ro.romstats.name=Ganbarou_$NEW_DEVICE"
echo $ROMSTATS_NAME >> $REPACK/ota/system/build.prop
ROMSTATS_VERSION="ro.romstats.version=V$gooversion_t.$goobuild_t"
echo $ROMSTATS_VERSION >> $REPACK/ota/system/build.prop
echo "ro.romstats.tframe=7" >> $REPACK/ota/system/build.prop

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Enable ADB and MTP"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
	-e 's:persist.sys.usb.config=mtp:persist.sys.usb.config=mtp,adb': \
	$REPACK/ota/system/build.prop
$SED -i \
	'/^$/d' \
	$REPACK/ota/system/build.prop

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Ganbarou specific changelog file"
echo -e $CL_GRN"============================================"$CL_RST
echo " " >> $ANDROID_BUILD_TOP/Ganbarou_Changelog.txt
echo "CM changelog below:" >> $ANDROID_BUILD_TOP/Ganbarou_Changelog.txt
echo "===================" >> $ANDROID_BUILD_TOP/Ganbarou_Changelog.txt
echo " " >> $ANDROID_BUILD_TOP/Ganbarou_Changelog.txt
cat $REPACK/ota/system/etc/CHANGELOG-CM.txt >> $ANDROID_BUILD_TOP/Ganbarou_Changelog.txt
rm $REPACK/ota/system/etc/CHANGELOG-CM.txt
cp $ANDROID_BUILD_TOP/Ganbarou_Changelog.txt $REPACK/ota/system/etc/Ganbarou_Changelog.txt

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Ganbarou specific data files"
echo -e $CL_GRN"============================================"$CL_RST
mkdir $REPACK/ota/data
mkdir $REPACK/ota/data/app
if [ $NEW_DEVICE2 -eq 1 ] || [ $TEST_BUILD -eq 1 ]; then
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/data/app/. $REPACK/ota/data/app/.
else
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/datap/app/. $REPACK/ota/data/app/.
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/systemapp-p/. $REPACK/ota/system/app/.
fi

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Copy hosts, 99ganbarou and gps.conf"
echo -e $CL_GRN"============================================"$CL_RST
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/gps.conf $REPACK/ota/system/etc/gps.conf
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/hosts $REPACK/ota/system/etc/hosts
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/init.d/99Ganbarou $REPACK/ota/system/etc/init.d/99Ganbarou

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add new APN for Softbank BIZflat connection"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
	-e 's:</apns>:<apn carrier="Softbank (BizFlat)" mcc="440" mnc="20" apn="bizflat.softbank" user="biz@bizflat.softbank" password="biz" type="default,supl" /></apns>': \
	$REPACK/ota/system/etc/apns-conf.xml
echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add new APN for Softbank 4G Smartphone connection"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
	-e 's:</apns>:<apn carrier="Softbank (4G)" mcc="440" mnc="20" apn="fourgsmartphone" type="default,supl,mms,hipri" /></apns>': \
	$REPACK/ota/system/etc/apns-conf.xml

if [ $NEW_DEVICE2 -eq 1 ] || [ $TEST_BUILD -eq 1 ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Add Ganbarou tablet boot animation"
   echo -e $CL_GRN"============================================"$CL_RST
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/bootanimation-t/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
fi
if [ $NEW_DEVICE == "GT-N7000" ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Add Ganbarou N7000 boot animation"
   echo -e $CL_GRN"============================================"$CL_RST
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/bootanimation-p/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
fi
if [ $NEW_DEVICE == "GT-I9505" ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Add Ganbarou SGS4 boot animation"
   echo -e $CL_GRN"============================================"$CL_RST
   cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/bootanimation-p2/bootanimation.zip $REPACK/ota/system/media/bootanimation.zip
fi

if [ $NEW_DEVICE2 -eq 1 ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Make copy of ota for $NEW_DEVICE1 ROM"
   echo -e $CL_GRN"============================================"$CL_RST
   mkdir $REPACK/ota1
   cp -rf $REPACK/ota/. $REPACK/ota1/.
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Change $NEW_DEVICE to $NEW_DEVICE1 in build.prop"
   echo -e $CL_GRN"But keep ro.product.device for Google Play"
   echo -e $CL_GRN"============================================"$CL_RST
   $SED -i \
   	-e "s:${NEW_DEVICE}:${NEW_DEVICE1}:" \
	$REPACK/ota1/system/build.prop
   OLD_PROD_DEV="ro.product.device=$NEW_DEVICE1"
   NEW_PROD_DEV="ro.product.device=$OLD_DEVICE2"
   $SED -i \
   	-e "s:${OLD_PROD_DEV}:${NEW_PROD_DEV}:" \
	$REPACK/ota1/system/build.prop
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Change device & build info in updater script"
   echo -e $CL_GRN"============================================"$CL_RST
   $SED -i \
   	-e "s:${DEVICE_INFO}:${DEVICE_INFO1}:" \
	$REPACK/ota1/META-INF/com/google/android/updater-script
fi

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Zipping Ganbarou $NEW_DEVICE ROM"
echo -e $CL_GRN"============================================"$CL_RST
( cd $REPACK/ota; zip $QUIET -r $REPACK/update.zip . )
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Zipping Ganbarou $NEW_DEVICE1 ROM"
   echo -e $CL_GRN"============================================"$CL_RST
   ( cd $REPACK/ota1; zip $QUIET -r $REPACK/update1.zip . )
fi
echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Sign Ganbarou $NEW_DEVICE ROM"
echo -e $CL_GRN"============================================"$CL_RST
SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
   java -Xmx1024m \
   	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update.zip $OUTFILE

if [ $NEW_DEVICE2 -eq 1 ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Sign Ganbarou $NEW_DEVICE1 ROM"
   echo -e $CL_GRN"============================================"$CL_RST
   SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
   java -Xmx1024m \
	-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update1.zip $OUTFILE1
fi

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Cleanup temporary folders"
echo -e $CL_GRN"============================================"$CL_RST
rm -rf $REPACK

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Create a md5 checksum image of the repacked $NEW_DEVICE package"
echo -e $CL_GRN"============================================"$CL_RST
(
img=`basename $OUTFILE`
cd `dirname $OUTFILE`
$MD5 $img >$img.md5sum
)

if [ $NEW_DEVICE2 -eq 1 ]; then
   echo -e $CL_GRN"============================================"$CL_RST
   echo -e $CL_GRN"Create a md5 checksum image of the repacked $NEW_DEVICE1 package"
   echo -e $CL_GRN"============================================"$CL_RST
   (
   img=`basename $OUTFILE1`
   cd `dirname $OUTFILE1`
   $MD5 $img >$img.md5sum
   )
fi

echo -e $CL_MAG"============================================"$CL_RST
echo -e $CL_MAG"Package complete: $OUTFILE"
echo -e $CL_MAG"============================================"$CL_RST
if [ $NEW_DEVICE2 -eq 1 ]; then
   echo -e $CL_MAG"Package complete: $OUTFILE1"
fi

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Copy to shared directory and cleanup"
echo -e $CL_GRN"============================================"$CL_RST
mv $OUTFILE $ANDROID_BUILD_TOP/
mv $OUTFILE.md5sum $ANDROID_BUILD_TOP/
if [ $NEW_DEVICE2 -eq 1 ]; then
   mv $OUTFILE1 $ANDROID_BUILD_TOP/
   mv $OUTFILE1.md5sum $ANDROID_BUILD_TOP/
fi

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Cleanup temporary folders"
echo -e $CL_GRN"============================================"$CL_RST
rm -rf $OUT/cm-10.2*.zip
rm -rf $OUT/cm-10.2*.md5sum
rm -rf $OUT/cm_*.zip
