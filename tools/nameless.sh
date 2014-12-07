#!/bin/bash
#

#****************************************************************
## Start timer:
START=$(date +%s)

#****************************************************************
## Set basic folder parameters:
echo "Setting folders"
USEROLD=`whoami`;
ANDROID_BUILD_TOP="/home/$USEROLD/${PWD##*/}"
androidtop=$ANDROID_BUILD_TOP
secsign=$ANDROID_BUILD_TOP/build/target/product/security
OUT_TARGET_HOST="linux-x86"
MD5=md5sum
export NOW=$(date +"%Y-%m-%d")
NOWORG=$(date +"%Y%m%d")
SECURITYDIR="$ANDROID_BUILD_TOP/build/target/product/security"

#****************************************************************
## Some stuff for the build tools:
export ROM_BUILDTIME_CUSTOM=$NOWORG
export USE_SQUISHER=yes

#****************************************************************
## Set ROM version
export ROM_VERSION=$(grep VERSION_ROMSTAT changelog.txt | cut -d \" -f2)
echo "ROM_VERSION = "$ROM_VERSION
export ROM_MOD=$(grep VERSION_GOO changelog.txt | cut -d \" -f2)
echo "ROM_MOD = "$ROM_MOD

. $ANDROID_BUILD_TOP/vendor/nameless/tools/functions

#****************************************************************
## Check for missing parameters:

if [ "$1" != "p4w"  ] && [ "$1" != "p4"  ] && [ "$1" != "s4"  ] && [ "$1" != "p600"  ]
then
  echo "No target device defined"
  exit 0
fi

#****************************************************************
## Set target:

if [ "$1" = "p4w" ]
then
trgt=p4wifi
NEW_DEVICE="GT-P7510"
NEW_DEVICE1="GT-P7511"
OLD_DEVICE="p4wifi"
OLD_DEVICE1="p4wifi-n"
fi

if [ "$1" = "p4" ]
then
trgt=p4
NEW_DEVICE="GT-P7500"
NEW_DEVICE1="GT-P7501"
OLD_DEVICE="p4"
OLD_DEVICE1="p4-n"
fi

if [ "$1" = "s4" ]
then
trgt=jflte
OLD_DEVICE="jflte"
fi

if [ "$1" = "p600" ]
then
trgt=lt03wifi
OLD_DEVICE="lt03wifi"
fi

clean=n
if [ "$2" = "c" ]
then
clean=c
fi

## set output folder
OUT="$ANDROID_BUILD_TOP/out/target/product/$OLD_DEVICE"
REPACK="$OUT/repack.d"
finalout=$ANDROID_BUILD_TOP/out/target/product/$trgt

## in case out folder was deleted!!!
mkdir -p $ANDROID_BUILD_TOP/out/target/product/$trgt

#****************************************************************
## Start the build:
echo "A nameless ROM will be build for $trgt"

#****************************************************************
## Clean environment:
cd $androidtop
if [ "$clean" = "c" ]
then
echo "Cleaning"
make installclean
fi

#****************************************************************
## Make the build:
cd $androidtop/
. build/envsetup.sh
export USE_CCACHE=1
brunch `echo $trgt`
if [ $? -eq 0 ]; then
	echo -e $CL_MAG"=============================================="$CL_RST
	echo -e $CL_RED"Build successfull"$CL_RST
	echo -e $CL_MAG"=============================================="$CL_RST
	#****************************************************************
	## Correct filename if necessary:
	NOWORG=$(date +"%Y%m%d")
        YDAYORG=$(date --date="yesterday" +"%Y%m%d")
        # If build is from yesterday and/or HOMEMADE is missing in filename
        NEWNAME="$OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE-HOMEMADE.zip"
        if [ -f $OUT/nameless-4.4.4-$YDAYORG-$OLD_DEVICE.zip ]; then
		echo -e $CL_MAG"=============================================="$CL_RST
		echo -e $CL_RED"Build is from yesterday and HOMEMADE is missing in filename"$CL_RST
		echo -e $CL_MAG"=============================================="$CL_RST
                ORGNAME="$OUT/nameless-4.4.4-$YDAYORG-$OLD_DEVICE.zip"
                mv $ORGNAME $NEWNAME
        fi
        # If build is from yesterday
        if [ -f $OUT/nameless-4.4.4-$YDAYORG-$OLD_DEVICE-HOMEMADE.zip ]; then
		echo -e $CL_MAG"=============================================="$CL_RST
		echo -e $CL_RED"Build is from yesterday"$CL_RST
		echo -e $CL_MAG"=============================================="$CL_RST
                ORGNAME="$OUT/nameless-4.4.4-$YDAYORG-$OLD_DEVICE-HOMEMADE.zip"
                mv $ORGNAME $NEWNAME
        fi
        # If HOMEMADE is missing in filename
        if [ -f $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE.zip ]; then
		echo -e $CL_MAG"=============================================="$CL_RST
		echo -e $CL_RED"HOMEMADE is missing in filename"$CL_RST
		echo -e $CL_MAG"=============================================="$CL_RST
                ORGNAME="$OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE.zip"
                mv $ORGNAME $NEWNAME
        fi
	#****************************************************************
	## Copy the build if it is for a tablet:
	if [ $trgt == "p4" ] || [ $trgt == "p4wifi" ]; then
		#****************************************************************
		## Make the GT-P7501 or GT-P7511 variants
		echo -e $CL_MAG"=============================================="$CL_RST
		echo -e $CL_RED"Making p4n / p4nwifi versions"$CL_RST
		echo -e $CL_MAG"=============================================="$CL_RST
		OTAPACKAGE="$OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE-HOMEMADE.zip"
		mkdir $REPACK
		mkdir $REPACK/ota1
		cd $REPACK/ota1
		printf "Unpacking $OTAPACKAGE..."
		unzip -q $OTAPACKAGE
		echo -e $CL_GRN"============================================"$CL_RST
		echo -e $CL_GRN"Change $NEW_DEVICE to $NEW_DEVICE1 in build.prop"
		echo -e $CL_GRN"============================================"$CL_RST
		sed -i \
			-e "s:${NEW_DEVICE}:${NEW_DEVICE1}:" \
			$REPACK/ota1/system/build.prop
		echo -e $CL_GRN"============================================"$CL_RST
		echo -e $CL_GRN"Change $NEW_DEVICE to $NEW_DEVICE1 in updater-script"
		echo -e $CL_GRN"============================================"$CL_RST
		sed -i \
			-e "s:${NEW_DEVICE}:${NEW_DEVICE1}:" \
			$REPACK/ota1/META-INF/com/google/android/updater-script
		echo -e $CL_GRN"============================================"$CL_RST
		echo -e $CL_GRN"Zipping Ganbarou $NEW_DEVICE1 ROM"
		echo -e $CL_GRN"============================================"$CL_RST
		( cd $REPACK/ota1; zip -q -r $REPACK/update1.zip . )
		echo -e $CL_GRN"============================================"$CL_RST
		echo -e $CL_GRN"Sign Ganbarou $NEW_DEVICE1 ROM"
		echo -e $CL_GRN"============================================"$CL_RST
		SECURITYDIR=$ANDROID_BUILD_TOP/build/target/product/security
		java -Xmx1024m \
		-jar $ANDROID_BUILD_TOP/out/host/$OUT_TARGET_HOST/framework/signapk.jar \
		-w $SECURITYDIR/testkey.x509.pem $SECURITYDIR/testkey.pk8 \
		$REPACK/update1.zip $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE1-HOMEMADE.zip
		echo -e $CL_GRN"============================================"$CL_RST
		echo -e $CL_GRN"Create a md5 checksum image of the repacked $NEW_DEVICE1 package"
		echo -e $CL_GRN"============================================"$CL_RST
		(
		img=`basename $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE1-HOMEMADE.zip`
		cd `dirname $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE1-HOMEMADE.zip`
		$MD5 $img >$img.md5sum
		)
		ZIPSIZE=`ls -lah $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE1-HOMEMADE.zip | awk '{ print $5}' `
                rm -f -r -d $REPACK
		echo -e
		echo -e $CL_CYN"===========-Package complete-==========="$CL_RST
		echo -e $CL_CYN"zip:"$CL_MAG" $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE1-HOMEMADE.zip"$CL_RST
		echo -e $CL_CYN"md5:"$CL_MAG" $(cat $OUT/nameless-4.4.4-$NOWORG-$OLD_DEVICE1-HOMEMADE.zip.md5sum | awk '{ print $1 }')"$CL_RST
		echo -e $CL_CYN"size:"$CL_MAG" $ZIPSIZE"$CL_RST
		echo -e $CL_CYN"========================================"$CL_RST
		echo -e
	fi
	echo "Copying fininalized build to AndroidFlash directory"
	cp -f $finalout/nameless-*.zip $androidtop/.
else
	echo -e $CL_MAG"=============================================="$CL_RST
	echo -e $CL_RED"Build failed"$CL_RST
	echo -e $CL_MAG"=============================================="$CL_RST
fi

#****************************************************************
## Report timer:
END=$(date +%s)
ELAPSED=$((END - START))
E_MIN=$((ELAPSED / 60))
E_SEC=$((ELAPSED - E_MIN * 60))
printf "${txtgrn}Elapsed: "
[ $E_MIN != 0 ] && printf "%d min(s) " $E_MIN
printf "%d sec(s)\n ${txtrst}" $E_SEC
