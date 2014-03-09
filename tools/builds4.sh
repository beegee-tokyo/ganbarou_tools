./prebuilts/misc/linux-x86/ccache/ccache -M 10G
export USE_CCACHE=1
. build/envsetup.sh
lunch full_jflte-userdebug
make otapackage

   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"=============================================="$CL_RST
      echo -e $CL_GRN"Build for GT-I9505 successfull"$CL_RST
      echo -e $CL_MAG"=============================================="$CL_RST

# $NEW_DEVICE = GT-P7500 or GT-P7510 or GT-N7000 or GT-I9300 or GT-I9505
# $NEW_DEVICE1 = GT-P7501 or GT-P7511
# $NEW_DEVICE2 = 1 for P7501/P7511 and 0 for N7000 or GT-I9300 or GT-I9505
# $OLD_DEVICE = p4 or p4wifi or n7000 or jflte or i9300
# KERNEL_VERSION = infamous or pershoot
# TEST_BUILD = 1 if quick build only for P7500 else it is 0

NEW_DEVICE=$1
NEW_DEVICE1=$2
NEW_DEVICE2=$3
OLD_DEVICE=$4
KERNEL_VERSION=$5
TEST_BUILD=$6

# set these variables fix for the tests
NEW_DEVICE=GT-I9505
NEW_DEVICE1=GT-I9505
NEW_DEVICE2=0
OLD_DEVICE=jflte
KERNEL_VERSION=cm
TEST_BUILD=1

# other global variables that usually come from makeit.sh but are missing for the tests
gooversion_t="1"
goobuild_t="00"
gooversion_build_t="100"
export USEROLD=`whoami`;

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
echo -e $CL_GRN"Amai patches - Set common variables"$CL_RST
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
echo -e $CL_GRN"Unpack $NEW_DEVICE for Amai patches"
echo -e $CL_GRN"============================================"$CL_RST
OUT="$ANDROID_BUILD_TOP/out/target/product/$OLD_DEVICE"
REPACK="$OUT/repack.d"
OUTFILE="$OUT/Amai-$NEW_DEVICE-v$gooversion_t.$goobuild_t-$NOW.zip"
DEVICE_VERSION="Version $gooversion_t.$goobuild_t"
DEVICE_INFO="for $NEW_DEVICE"
OTAPACKAGE="$OUT/full_$OLD_DEVICE-ota-eng.$USEROLD.zip"
mkdir $REPACK
mkdir $REPACK/ota
cd $REPACK/ota
printf "Unpacking $OTAPACKAGE..."
unzip $QUIET $OTAPACKAGE
echo $DEVICE_VERSION
echo $DEVICE_INFO

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Amai info into updater-script"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
		-e "s:REPLACE_WITH_VERSION:${DEVICE_VERSION}:" \
	$REPACK/ota/META-INF/com/google/android/updater-script
$SED -i \
		-e "s:REPLACE_WITH_DEVICE:${DEVICE_INFO}:" \
	$REPACK/ota/META-INF/com/google/android/updater-script

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Change $OLD_DEVICE to $NEW_DEVICE in build.prop"
echo -e $CL_GRN"But keep ro.product.device for Google Play"
echo -e $CL_GRN"============================================"$CL_RST
$SED -i \
		-e "s:${OLD_DEVICE}:${NEW_DEVICE}:" \
	$REPACK/ota/system/build.prop
OLD_PROD_DEV="ro.product.device=$NEW_DEVICE"
NEW_PROD_DEV="ro.product.device=$OLD_DEVICE"
$SED -i \
		-e "s:${OLD_PROD_DEV}:${NEW_PROD_DEV}:" \
	$REPACK/ota/system/build.prop

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Goo & romstats info to build.prop"
echo -e $CL_GRN"============================================"$CL_RST
#echo " " >> $REPACK/ota/system/build.prop
#echo "#" >> $REPACK/ota/system/build.prop
#echo "# BeeGee_Tokyo tweaks" >> $REPACK/ota/system/build.prop
#echo "#" >> $REPACK/ota/system/build.prop
#echo "ro.com.google.clientidbase=android-google" >> $REPACK/ota/system/build.prop
#echo "keyguard.no_require_sim=true" >> $REPACK/ota/system/build.prop
#echo "ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html" >> $REPACK/ota/system/build.prop
#echo "ro.url.legal.android_privacy=http://www.google.com/intl/%s/mobile/android/basic/privacy.html" >> $REPACK/ota/system/build.prop
#echo "ro.com.android.wifi-watchlist=GoogleGuest" >> $REPACK/ota/system/build.prop
#echo "ro.setupwizard.enterprise_mode=1" >> $REPACK/ota/system/build.prop
#echo "ro.com.android.dataroaming=false" >> $REPACK/ota/system/build.prop
#echo "persist.sys.root_access=1" >> $REPACK/ota/system/build.prop
#echo "ro.HOME_APP_ADJ=1" >> $REPACK/ota/system/build.prop
#echo "debug.sf.hw=1" >> $REPACK/ota/system/build.prop
#echo "windowsmgr.max_events_per_sec=240" >> $REPACK/ota/system/build.prop
#echo "ro.telephony.call_ring.delay=0" >> $REPACK/ota/system/build.prop
#echo "wifi.supplicant_scan_interval=180" >> $REPACK/ota/system/build.prop
#echo "pm.sleep_mode=1" >> $REPACK/ota/system/build.prop
#echo "ro.ril.disable.power.collapse=0" >> $REPACK/ota/system/build.prop
#echo "mot.proximity.delay=25" >> $REPACK/ota/system/build.prop
#echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
#echo "video.accelerate.hw=1" >> $REPACK/ota/system/build.prop
#echo "ro.media.enc.jpeg.quality=100" >> $REPACK/ota/system/build.prop
#echo "persist.sys.purgeable_assets=1" >> $REPACK/ota/system/build.prop
#echo "ro.tether.denied=false" >> $REPACK/ota/system/build.prop
#echo "ro.secure=0" >> $REPACK/ota/system/build.prop
#echo "debug.performance.tuning=1" >> $REPACK/ota/system/build.prop
#echo "ro.max.fling_velocity=12000" >> $REPACK/ota/system/build.prop
#echo "ro.min.fling_velocity=8000" >> $REPACK/ota/system/build.prop
#echo "dalvik.vm.dexopt-flags=m=v,o=y" >> $REPACK/ota/system/build.prop
#echo "net.tcp.buffersize.default=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
#echo "net.tcp.buffersize.wifi=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
#echo "net.tcp.buffersize.umts=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
#echo "net.tcp.buffersize.gprs=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
#echo "net.tcp.buffersize.edge=4096,87380,256960,4096,16384,256960" >> $REPACK/ota/system/build.prop
#echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# Goo Manager info" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.goo.developerid=beegee_tokyo" >> $REPACK/ota/system/build.prop
RO_GOO_BOARD="ro.goo.board=$NEW_DEVICE"
echo $RO_GOO_BOARD >> $REPACK/ota/system/build.prop
RO_GOO_ROM="ro.goo.rom=Amai_$NEW_DEVICE"
echo $RO_GOO_ROM >> $REPACK/ota/system/build.prop
GOO_BUILD_VERSION="ro.goo.version=$gooversion_build_t"
echo $GOO_BUILD_VERSION >> $REPACK/ota/system/build.prop
echo " " >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "# ROM Statistics and ROM Identification" >> $REPACK/ota/system/build.prop
echo "#" >> $REPACK/ota/system/build.prop
echo "ro.romstats.url=http://www.desire.giesecke.tk/romstats/" >> $REPACK/ota/system/build.prop
ROMSTATS_NAME="ro.romstats.name=Amai_$NEW_DEVICE"
echo $ROMSTATS_NAME >> $REPACK/ota/system/build.prop
ROMSTATS_VERSION="ro.romstats.version=V$gooversion_t.$goobuild_t"
echo $ROMSTATS_VERSION >> $REPACK/ota/system/build.prop
echo "ro.romstats.tframe=7" >> $REPACK/ota/system/build.prop

#echo -e $CL_GRN"============================================"$CL_RST
#echo -e $CL_GRN"Enable ADB and MTP"
#echo -e $CL_GRN"============================================"$CL_RST
#$SED -i \
#	-e 's:persist.sys.usb.config=mtp:persist.sys.usb.config=mtp,adb': \
#	$REPACK/ota/system/build.prop
#$SED -i \
#	'/^$/d' \
#	$REPACK/ota/system/build.prop

#echo -e $CL_GRN"============================================"$CL_RST
#echo -e $CL_GRN"Add SuperUser files"
#echo -e $CL_GRN"============================================"$CL_RST
#rm -f $REPACK/ota/system/bin/su
#rm -f $REPACK/ota/system/xbin/su
#rm -f $REPACK/ota/system/xbin/daemonsu
#rm -f $REPACK/ota/system/bin/.ext/.su
#rm -f $REPACK/ota/system/etc/install-recovery.sh
#rm -f $REPACK/ota/system/etc/init.d/99SuperSUDaemon
#rm -f $REPACK/ota/system/etc/.installed_su_daemon
#rm -f $REPACK/ota/system/app/Superuser.apk
#rm -f $REPACK/ota/system/app/Superuser.odex
#rm -f $REPACK/ota/system/app/SuperUser.apk
#rm -f $REPACK/ota/system/app/SuperUser.odex
#rm -f $REPACK/ota/system/app/superuser.apk
#rm -f $REPACK/ota/system/app/superuser.odex
#rm -f $REPACK/ota/system/app/Supersu.apk
#rm -f $REPACK/ota/system/app/Supersu.odex
#rm -f $REPACK/ota/system/app/SuperSU.apk
#rm -f $REPACK/ota/system/app/SuperSU.odex
#rm -f $REPACK/ota/system/app/supersu.apk
#rm -f $REPACK/ota/system/app/supersu.odex
#rm -f $REPACK/ota/data/dalvik-cache/*com.noshufou.android.su*
#rm -f $REPACK/ota/data/dalvik-cache/*com.koushikdutta.superuser*
#rm -f $REPACK/ota/data/dalvik-cache/*com.mgyun.shua.su*
#rm -f $REPACK/ota/data/dalvik-cache/*Superuser.apk*
#rm -f $REPACK/ota/data/dalvik-cache/*SuperUser.apk*
#rm -f $REPACK/ota/data/dalvik-cache/*superuser.apk*
#rm -f $REPACK/ota/data/dalvik-cache/*eu.chainfire.supersu*
#rm -f $REPACK/ota/data/dalvik-cache/*Supersu.apk*
#rm -f $REPACK/ota/data/dalvik-cache/*SuperSU.apk*
#rm -f $REPACK/ota/data/dalvik-cache/*supersu.apk*
#rm -f $REPACK/ota/data/dalvik-cache/*.oat
#rm -f $REPACK/ota/data/app/com.noshufou.android.su-*
#rm -f $REPACK/ota/data/app/com.koushikdutta.superuser-*
#rm -f $REPACK/ota/data/app/com.mgyun.shua.su-*
#rm -f $REPACK/ota/data/app/eu.chainfire.supersu-*
#cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/superuser/system/. $REPACK/ota/system/.
#echo 1 > $REPACK/ota/system/etc/.installed_su_daemon
#echo 1 > $REPACK/ota/system/etc/.has_su_daemon

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Add Amai specific data files"
echo -e $CL_GRN"============================================"$CL_RST
mkdir $REPACK/ota/data
mkdir $REPACK/ota/data/app
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/data/app/. $REPACK/ota/data/app/.
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/datap/app/. $REPACK/ota/data/app/.
cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/systemapp-p/. $REPACK/ota/system/app/.

#echo -e $CL_GRN"============================================"$CL_RST
#echo -e $CL_GRN"Copy hosts, 98ganbarou and gps.conf"
#echo -e $CL_GRN"============================================"$CL_RST
#cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/gps.conf $REPACK/ota/system/etc/gps.conf
#cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/hosts $REPACK/ota/system/etc/hosts
#cp -r -f -v $ANDROID_BUILD_TOP/ganbarou_tools/patches/ganbarou/etc/init.d/98Ganbarou $REPACK/ota/system/etc/init.d/97Ganbarou

#echo -e $CL_GRN"============================================"$CL_RST
#echo -e $CL_GRN"Add Japan APNs"
#echo -e $CL_GRN"============================================"$CL_RST
#$SED -i \
#	-e 's:</apns>:': \
#	$REPACK/ota/system/etc/apns-conf.xml
#cat $ANDROID_BUILD_TOP/ganbarou_tools/patches/japan.apns >> $REPACK/ota/system/etc/apns-conf.xml

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Zipping Amai $NEW_DEVICE ROM"
echo -e $CL_GRN"============================================"$CL_RST
( cd $REPACK/ota; zip $QUIET -r $REPACK/update.zip . )

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Sign Amai $NEW_DEVICE ROM"
echo -e $CL_GRN"============================================"$CL_RST
SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
	java -Xmx1024m \
		-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
	-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
	$REPACK/update.zip $OUTFILE

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

echo -e $CL_MAG"============================================"$CL_RST
echo -e $CL_MAG"Package complete: $OUTFILE"
echo -e $CL_MAG"============================================"$CL_RST

echo -e $CL_GRN"============================================"$CL_RST
echo -e $CL_GRN"Copy to shared directory and cleanup"
echo -e $CL_GRN"============================================"$CL_RST
mv $OUTFILE $ANDROID_BUILD_TOP/
mv $OUTFILE.md5sum $ANDROID_BUILD_TOP/

	else
      echo -e $CL_MAG"=============================================="$CL_RST
      echo -e $CL_RED"Build for GT-I9505 failed"$CL_RST
      echo -e $CL_MAG"=============================================="$CL_RST
   fi
