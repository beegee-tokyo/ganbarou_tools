echo -e $CL_MAG"============================================"$CL_RST
echo -e $CL_MAG"Welcome to <build the Ganbarou ROM> script"
echo -e $CL_MAG"Use <./makeit.sh help> to see what option you can choose"
echo -e $CL_MAG"============================================"$CL_RST
# build with colors!
CL_RED="\033[31m"
CL_GRN="\033[32m"
CL_YLW="\033[33m"
CL_BLU="\033[34m"
CL_MAG="\033[35m"
CL_CYN="\033[36m"
CL_RST="\033[0m"
# Initial set of variables to do nothing!
export DO_CLEAN=1
export DO_P7500=1 
export DO_P750T=1 
export DO_P7510=1 
export DO_N7000=1
export DO_P5100=1

# Check the parameters given
for PARAM in "$@"
do
   if [[ $PARAM == help ]]; then
      echo -e $CL_MAG"Help for the script"
      echo "You have 2 possibilities to run the script"
      echo -e $CL_BLU"a) no parameters"
      echo "   build the ROMs for GT-P7500/P7501/P7510/P7511 and GT-N7000"
      echo "b) with one or several of the following parameters"
      echo -e $CL_YLW"   <all> ==> builds the ROMs for GT-P7500/P7501/P7510/P7511 and for the GT-N7000"
      echo -e $CL_YLW"   <tab> ==> builds the ROMs for GT-P7500/P7501/P7510/P7511 only, not for the GT-N7000"
      echo -e $CL_YLW"   <3g> ==> builds the ROMs for GT-P7500/P7501 only, not for the GT-P7510/P7511 or GT-N7000"
      echo -e $CL_YLW"   <wifi> ==> builds the ROMs for GT-P7510/P7511 only, not for the GT-P7500/P7501 or GT-N7000"
      echo -e $CL_YLW"   <phone> ==> build the ROM for GT-N7000 only, not for the GT-P7500/P7501/P7510/P7511"
      echo -e $CL_YLW"   <tab2> ==> build the ROM for GT-P5100 only, not for the GT-P7500/P7501/P7510/P7511"
      echo -e $CL_YLW"   <clean> ==> can be used alone, then it cleans up the <out> folder and builds the ROMs for GT-N7000"
      echo -e $CL_YLW"               and for the GT-P7500/P7501/P7510/P7511"
      echo -e $CL_YLW"           ==> can be used together with other parameters, then it cleans up the <out> folder and "
      echo -e $CL_YLW"               builds the ROMs as selected by the second parameter"
      echo -e $CL_YLW" "
      echo -e $CL_CYN"Examples:"
      echo -e $CL_CYN"./makeit.sh  ==> builds all ROMs"
      echo -e $CL_CYN"./makeit.sh clean ==> starts a clean build of all ROMs"
      echo -e $CL_CYN"./makeit.sh tab clean ==> starts a clean build of tablet ROMs only"
      echo -e $CL_CYN"./makeit.sh clean phone ==> starts a clean build of the phone ROM only"
      echo -e $CL_CYN"./makeit.sh clean phone wifi ==> starts a clean build of the phone ROM and WiFi tablet ROM only"
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
   if [[ $PARAM == tab2 ]]; then 
      export DO_P5100=0 
   fi
   if [[ $PARAM == t ]]; then 
      export DO_P750T=0 
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
      export DO_P5100=0 
   fi
done
if [ $DO_P7500 -eq 1 ] && [ $DO_P750T -eq 1 ] && [ $DO_P7510 -eq 1 ] && [ $DO_P5100 -eq 1 ] && [ $DO_N7000 -eq 1 ]; then
      export DO_N7000=0 
      export DO_P7500=0 
      export DO_P7510=0 
      export DO_P5100=0
fi   
if [ $DO_CLEAN -eq 0 ]; then
   CLEAN_TXT1="a"
   CLEAN_TXT2=$CL_RED
   CLEAN_TXT3=" CLEAN"
   CLEAN_TXT4=$CL_RST
   CLEAN_TXT5=$CL_GRN" build of"
else
   CLEAN_TXT1="the"
   CLEAN_TXT2=""
   CLEAN_TXT3=""
   CLEAN_TXT4=""
   CLEAN_TXT5=$CL_GRN" build of"
fi
if [ $DO_P7500 -eq 0 ]; then
   P7500_TXT=" GT-P7500/P7501"
fi
if [ $DO_P750T -eq 0 ]; then
   P7500_TXT=" GT-P7500"
fi
if [ $DO_P7510 -eq 0 ]; then
   P7510_TXT=" GT-P7510/P7511"
fi
if [ $DO_N7000 -eq 0 ]; then
   N7000_TXT=" GT-N7000"
fi
if [ $DO_P5100 -eq 0 ]; then
   P5100_TXT=" GT-P5100"
fi
echo -n -e $CL_GRN"Start $CLEAN_TXT1$CLEAN_TXT2$CLEAN_TXT3$CLEAN_TXT4$CLEAN_TXT5$P7500_TXT$P7510_TXT$N7000_TXT$P5100_TXT? [Y/n]: "$CL_RST
read yno
case $yno in
        [nN] | [n|N][O|o] )
                echo -e $CL_RED"Ok, build is stopped"$CL_RST;
                exit 1
                ;;
        *) echo -e $CL_GRN"Ok, be patient and wait"$CL_RST
            ;;
esac

# get time of startup
res1=$(date +%s.%N)

echo -e $CL_MAG"============================================"$CL_RST
echo -e $CL_MAG"set GooManager ROM version"$CL_RST
echo -e $CL_MAG"and create changelog file"$CL_RST
echo -e $CL_MAG"============================================"$CL_RST

DIR="/home/$USER/${PWD##*/}"
export gooversion_t=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'VERSION_MAJOR = *' | sed  's/VERSION_MAJOR = //g')
export goobuild_t=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'VERSION_MINOR = *' | sed  's/VERSION_MINOR = //g')
export changelog_0=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_0 = *' | sed  's/CHANGELOG_0 = //g')
export changelog_1=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_1 = *' | sed  's/CHANGELOG_1 = //g')
export changelog_2=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_2 = *' | sed  's/CHANGELOG_2 = //g')
export changelog_3=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_3 = *' | sed  's/CHANGELOG_3 = //g')
export changelog_4=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_4 = *' | sed  's/CHANGELOG_4 = //g')
export changelog_5=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_5 = *' | sed  's/CHANGELOG_5 = //g')
export changelog_6=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_6 = *' | sed  's/CHANGELOG_6 = //g')
export changelog_7=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_7 = *' | sed  's/CHANGELOG_7 = //g')
export changelog_8=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_8 = *' | sed  's/CHANGELOG_8 = //g')
export changelog_9=$(cat $DIR/ganbarou_tools/tools/changelog.txt | grep 'CHANGELOG_9 = *' | sed  's/CHANGELOG_9 = //g')

#export gooversion_t="3"
#export goobuild_t="08"
export gooversion_build_t=$gooversion_t$goobuild_t

LOGFILE="Ganbarou-Changelog_"$gooversion_build_t".txt"
rm $DIR/$LOGFILE

echo "Changelog V"$gooversion_t"."$goobuild_t >> $LOGFILE
echo $changelog_0 >> $LOGFILE
if [ -n "$changelog_1" ]; then
   echo $changelog_1 >> $LOGFILE
fi
if [ -n "$changelog_2" ]; then
   echo $changelog_2 >> $LOGFILE
fi
if [ -n "$changelog_3" ]; then
   echo $changelog_3 >> $LOGFILE
fi
if [ -n "$changelog_4" ]; then
   echo $changelog_4 >> $LOGFILE
fi
if [ -n "$changelog_5" ]; then
   echo $changelog_5 >> $LOGFILE
fi
if [ -n "$changelog_6" ]; then
   echo $changelog_6 >> $LOGFILE
fi
if [ -n "$changelog_7" ]; then
   echo $changelog_7 >> $LOGFILE
fi
if [ -n "$changelog_8" ]; then
   echo $changelog_8 >> $LOGFILE
fi
if [ -n "$changelog_9" ]; then
   echo $changelog_9 >> $LOGFILE
fi

rm $DIR/Ganbarou_Changelog.txt
cp $DIR/$LOGFILE $DIR/Ganbarou_Changelog.txt

echo " " >> $DIR/Ganbarou_Changelog.txt
echo "Older versions:" >> $DIR/Ganbarou_Changelog.txt
echo "===============" >> $DIR/Ganbarou_Changelog.txt
echo " " >> $DIR/Ganbarou_Changelog.txt

#export changelog_old=$(cat $DIR/ganbarou_tools/tools/changelog.txt | sed -n '15,$ p')
cat $DIR/ganbarou_tools/tools/changelog.txt | sed -n '15,$ p' >> $DIR/Ganbarou_Changelog.txt

echo -e $CL_GRN"GooVersion = "$gooversion_t"."$goobuild_t""$CL_RST

echo -e $CL_MAG"============================================"$CL_RST
echo -e $CL_MAG"Setup ccache"$CL_RST
echo -e $CL_MAG"============================================"$CL_RST
ccache -M 20G
if [ $DO_CLEAN -eq 0 ]; then
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Clean-up out folder"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   make clean
fi
# For patchit.sh the params are:
# $NEW_DEVICE = GT-P7500 or GT-P7510 or GT-N7000 or GT-P5100
# $NEW_DEVICE1 = GT-P7501 or GT-P7511
# $NEW_DEVICE2 = 1 for P7501/P7511 and 0 for N7000 and P5100
# $OLD_DEVICE = p4 or p4wifi or n7000 or p5100
# all 4 params must be given!

if [ $DO_P750T -eq 0 ]; then
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Start the build for GT-P7500 pershoot kernel"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   res75001=$(date +%s.%N)
   . build/envsetup.sh && brunch p4
   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7500 pershoot kernel successfull"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P750TRESULT=0
      ./patchit.sh GT-P7500 GT-P7501 0 p4 pershoot
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7500 pershoot kernel failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P750TRESULT=1
   fi
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Start the build for GT-P7500 infamous kernel"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   res75001=$(date +%s.%N)
   . build/envsetup.sh && brunch p4p
   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7500 infamous kernel successfull"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P750TRESULT=0
      ./patchit.sh GT-P7500 GT-P7501 0 p4p infamous
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7500 infamous kernel failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P750TRESULT=1
   fi
   res75002=$(date +%s.%N)
else
   export P750TRESULT=1
fi
if [ $DO_P7500 -eq 0 ]; then
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Start the build for GT-P7500"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   res75001=$(date +%s.%N)
   . build/envsetup.sh && brunch p4
   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7500 successfull"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P7500RESULT=0
      ./patchit.sh GT-P7500 GT-P7501 1 p4
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7500 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P7500RESULT=1
   fi
   res75002=$(date +%s.%N)
else
   export P7500RESULT=1
fi
if [ $DO_P5100 -eq 0 ]; then
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Start the build for GT-P5100"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   res51001=$(date +%s.%N)
   . build/envsetup.sh && brunch p5100
   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P5100 successfull"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P5100RESULT=0
      ./patchit.sh GT-P5100 GT-P5100 0 p5100
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P5100 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P5100RESULT=1
   fi
   res51002=$(date +%s.%N)
else
   export P5100RESULT=1
fi
if [ $DO_P7510 -eq 0 ]; then
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Start the build for GT-P7510"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   res75101=$(date +%s.%N)
   . build/envsetup.sh && brunch p4wifi
   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7510 successfull"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P7510RESULT=0
      ./patchit.sh GT-P7510 GT-P7511 1 p4wifi
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7510 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export P7510RESULT=1
   fi
   res75102=$(date +%s.%N)
else
   export P7510RESULT=1
fi
if [ $DO_N7000 -eq 0 ]; then
   echo -e $CL_MAG"============================================"$CL_RST
   echo -e $CL_MAG"Start the build for GT-N7000"$CL_RST
   echo -e $CL_MAG"============================================"$CL_RST
   res70001=$(date +%s.%N)
   . build/envsetup.sh && brunch n7000
   if [ $? -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-N7000 successfull"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export N7000RESULT=0
      ./patchit.sh GT-N7000 GT-N7000 0 n7000
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-N7000 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
      export N7000RESULT=1
   fi
   res70002=$(date +%s.%N)
else
   export N7000RESULT=1
fi

echo -e $CL_MAG"============================================"$CL_RST
echo -e $CL_MAG"Build & Patch of Ganbarou ROM done"$CL_RST
echo -e $CL_MAG"============================================"$CL_RST

# finished? get elapsed time
res2=$(date +%s.%N)
echo -e $CL_GRN"${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res2 - $res1) / 60"|bc ) minutes ($(echo "$res2 - $res1"|bc ) seconds) ${txtrst}"$CL_RST

if [ $DO_P750T -eq 0 ]; then
   if [ $P750TRESULT -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7500 done"$CL_RST
      echo -e $CL_GRN"${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res75002 - $res75001) / 60"|bc ) minutes ($(echo "$res75002 - $res75001"|bc ) seconds) ${txtrst}"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7500 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   fi
fi
if [ $DO_P7500 -eq 0 ]; then
   if [ $P7500RESULT -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7500/7501 done"$CL_RST
      echo -e $CL_GRN"${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res75002 - $res75001) / 60"|bc ) minutes ($(echo "$res75002 - $res75001"|bc ) seconds) ${txtrst}"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7500/7501 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   fi
fi
if [ $DO_P5100 -eq 0 ]; then
   if [ $P5100RESULT -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P5100 done"$CL_RST
      echo -e $CL_GRN"${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res51002 - $res51001) / 60"|bc ) minutes ($(echo "$res51002 - $res51001"|bc ) seconds) ${txtrst}"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P5100 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   fi
fi
if [ $DO_P7510 -eq 0 ]; then
   if [ $P7510RESULT -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-P7510/7511 done"$CL_RST
      echo -e $CL_GRN"${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res75102 - $res75101) / 60"|bc ) minutes ($(echo "$res75102 - $res75101"|bc ) seconds) ${txtrst}"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-P7510/7511 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   fi
fi
if [ $DO_N7000 -eq 0 ]; then
   if [ $N7000RESULT -eq 0 ]; then
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_GRN"Build for GT-N7000 done"$CL_RST
      echo -e $CL_GRN"${bldgrn}Total time elapsed: ${txtrst}${grn}$(echo "($res70002 - $res70001) / 60"|bc ) minutes ($(echo "$res70002 - $res70001"|bc ) seconds) ${txtrst}"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   else
      echo -e $CL_MAG"============================================"$CL_RST
      echo -e $CL_RED"Build for GT-N7000 failed"$CL_RST
      echo -e $CL_MAG"============================================"$CL_RST
   fi
fi

