#!/bin/bash
#

#****************************************************************
## Start timer:
START=$(date +%s)

#****************************************************************
## Check for missing parameters:

if [ "$1" != "p4w"  ] && [ "$1" != "p4"  ] && [ "$1" != "s4"  ]
then
  echo "No target device defined"
  exit 0
fi

#****************************************************************
## Set target:

if [ "$1" = "p4w" ]
then
trgt=p4wifi
fi

if [ "$1" = "p4" ]
then
trgt=p4
fi

if [ "$1" = "s4" ]
then
trgt=jflte
fi

clean=n
if [ "$2" = "c" ]
then
clean=c
fi

#****************************************************************
## Set basic folder parameters:
echo "Setting folders"
## in case out folder was deleted!!!
mkdir ~/Nameless/out/target/product/$trgt
finalout=~/Nameless/out/target/product/$trgt
androidtop=~/Nameless
secsign=~/Nameless/build/target/product/security

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
	## Copy the build:
	echo "Copying fininalized build to AndroidFlash directory"
	cp -f $finalout/nameless-*.zip /media/sf_NewUploads/.
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