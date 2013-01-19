echo ============================================
echo 'Welcome to <build the Ganbarou ROM> script'
echo 'Use <./makeit.sh help> to see what option you can choose'
echo ============================================
# Initial set of variables to do nothing!
export DO_CLEAN=1
export DO_P7500=1 
export DO_P7510=1 
export DO_N7000=1 

# Check the parameters given
for PARAM in "$@"
do
   if [[ $PARAM == help ]]; then
      echo 'Help for the script'
      echo 'You have 2 possibilities to run the script'
      echo 'a) no parameters'
      echo '   build the ROMs for GT-P7500/P7501/P7510/P7511 and GT-N7000'
      echo 'b) with one or several of the following parameters'
      echo '   <all> ==> builds the ROMs for GT-P7500/P7501/P7510/P7511 and for the GT-N7000'
      echo '   <tab> ==> builds the ROMs for GT-P7500/P7501/P7510/P7511 only, not for the GT-N7000'
      echo '   <3g> ==> builds the ROMs for GT-P7500/P7501 only, not for the GT-P7510/P7511 or GT-N7000'
      echo '   <wifi> ==> builds the ROMs for GT-P7510/P7511 only, not for the GT-P7500/P7501 or GT-N7000'
      echo '   <phone> ==> build the ROM for GT-N7000 only, not for the GT-P7500/P7501/P7510/P7511'
      echo '   <clean> ==> can be used alone, then it cleans up the <out> folder and builds the ROMs for GT-N7000'
      echo '               and for the GT-P7500/P7501/P7510/P7511'
      echo '           ==> can be used together with other parameters, then it cleans up the <out> folder and '
      echo '               builds the ROMs as selected by the second parameter'
      echo ' '
      echo 'Examples:'
      echo './makeit.sh  ==> builds all ROMs'
      echo './makeit.sh clean ==> starts a clean build of all ROMs'
      echo './makeit.sh tab clean ==> starts a clean build of tablet ROMs only'
      echo './makeit.sh clean phone ==> starts a clean build of the phone ROM only'
      echo './makeit.sh clean phone wifi ==> starts a clean build of the phone ROM and WiFi tablet ROM only'
      exit $?
   fi
   if [[ $PARAM == clean ]]; then 
      export DO_CLEAN=0
   fi
   if [[ $PARAM == tab ]]; then 
      export DO_P7500=0 
      export DO_P7510=0 
   fi
   if [[ $PARAM == 3g ]]; then 
      export DO_P7500=0 
   fi
   if [[ $PARAM == wifi ]]; then 
      export DO_P7510=0 
   fi
   if [[ $PARAM == phone ]]; then 
      export DO_N7000=0 
   fi
   if [[ $PARAM == all ]]; then 
      export DO_N7000=0 
      export DO_P7500=0 
      export DO_P7510=0 
   fi
done
if [ $DO_P7500 -eq 1 ] && [ $DO_P7510 -eq 1 ] && [ $DO_N7000 -eq 1 ]; then
      export DO_N7000=0 
      export DO_P7500=0 
      export DO_P7510=0 
fi   
if [ $DO_CLEAN -eq 0 ]; then
   CLEAN_TXT='a clean build of'
else
   CLEAN_TXT='the build of'
fi
if [ $DO_P7500 -eq 0 ]; then
   P7500_TXT=' GT-P7500/P7501'
fi
if [ $DO_P7510 -eq 0 ]; then
   P7510_TXT=' GT-P7510/P7511'
fi
if [ $DO_N7000 -eq 0 ]; then
   N7000_TXT=' GT-N7000'
fi
echo -n "Start $CLEAN_TXT$P7500_TXT$P7510_TXT$N7000_TXT? [Y/n]: "
read yno
case $yno in
        [nN] | [n|N][O|o] )
                echo "Ok, build is stopped";
                exit 1
                ;;
        *) echo "Ok, be patient and wait"
            ;;
esac

echo ============================================
echo 'set GooManager ROM version'
echo ============================================
export gooversion_t="3"
export goobuild_t="00"
export gooversion_build_t=$gooversion_t$goobuild_t
echo ============================================
echo 'Setup ccache'
echo ============================================
ccache -M 20G
if [ $DO_CLEAN -eq 0 ]; then
   echo ============================================
   echo "Clean-up out folder"
   echo ============================================
   make clean
fi
# For patchit.sh the params are:
# $NEW_DEVICE = GT-P7500 or GT-P7510 or GT-N7000
# $NEW_DEVICE1 = GT-P7501 or GT-P7511
# $NEW_DEVICE2 = 1 for P7501/P7511 and 0 for N7000
# $OLD_DEVICE = p4 or p4wifi or n7000
# all 4 params must be given!

if [ $DO_P7500 -eq 0 ]; then
   echo ============================================
   echo 'Start the build for GT-P7500'
   echo ============================================
   . build/envsetup.sh && brunch p4
   if [ $? -eq 0 ]; then
      echo ============================================
      echo 'Build for GT-P7500 successfull'
      echo ============================================
      export P7500RESULT=0
      ./patchit.sh GT-P7500 GT-P7501 1 p4
   else
      echo ============================================
      echo 'Build for GT-P7500 failed'
      echo ============================================
      export P7500RESULT=1
   fi
else
   export P7500RESULT=1
fi
if [ $DO_P7510 -eq 0 ]; then
   echo ============================================
   echo 'Start the build for GT-P7510'
   echo ============================================
   . build/envsetup.sh && brunch p4wifi
   if [ $? -eq 0 ]; then
      echo ============================================
      echo 'Build for GT-P7510 successfull'
      echo ============================================
      export P7510RESULT=0
      ./patchit.sh GT-P7510 GT-P7511 1 p4wifi
   else
      echo ============================================
      echo 'Build for GT-P7510 failed'
      echo ============================================
      export P7510RESULT=1
   fi
else
   export P7510RESULT=1
fi
if [ $DO_N7000 -eq 0 ]; then
   echo ============================================
   echo 'Start the build for GT-N7000'
   echo ============================================
   . build/envsetup.sh && brunch n7000
   if [ $? -eq 0 ]; then
      echo ============================================
      echo 'Build for GT-N7000 successfull'
      echo ============================================
      export N7000RESULT=0
      ./patchit.sh GT-N7000 GT-N7000 0 n7000
   else
      echo ============================================
      echo 'Build for GT-N7000 failed'
      echo ============================================
      export N7000RESULT=1
   fi
else
   export N7000RESULT=1
fi

echo ============================================
echo 'Build & Patch of Ganbarou ROM done'
echo ============================================
echo "gooversion Tablet=$gooversion_t.$goobuild_t"
echo "gooversion Tablet=$gooversion_build_t"
if [ $DO_P7500 -eq 0 ]; then
   if [ $P7500RESULT -eq 0 ]; then
      echo ============================================
      echo 'Build for GT-P7500/7501 done'
      echo ============================================
   else
      echo ============================================
      echo 'Build for GT-P7500/7501 failed'
      echo ============================================
   fi
fi
if [ $DO_P7510 -eq 0 ]; then
   if [ $P7510RESULT -eq 0 ]; then
      echo ============================================
      echo 'Build for GT-P7510/7511 done'
      echo ============================================
   else
      echo ============================================
      echo 'Build for GT-P7510/7511 failed'
      echo ============================================
   fi
fi
if [ $DO_N7000 -eq 0 ]; then
   if [ $N7000RESULT -eq 0 ]; then
      echo ============================================
      echo 'Build for GT-N7000 done'
      echo ============================================
   else
      echo ============================================
      echo 'Build for GT-N7000 failed'
      echo ============================================
   fi
fi

