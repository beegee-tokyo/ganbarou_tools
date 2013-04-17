echo ============================================
echo 'Init local sync CM10'
echo 'repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1'
echo ============================================
repo init -u git://github.com/CyanogenMod/android.git -b cm-10.1
if [ $? -eq 0 ]; then
   echo ============================================
   echo 'Repo init successfull'
   echo ============================================
else
   echo ============================================
   echo 'Repo init failed'
   echo ============================================
   exit $?
fi
echo ============================================
echo 'Sync CM10.1'
echo 'repo sync -f -c -l'
echo ============================================
repo sync -f -c -l
echo $?
if [ $? -eq 0 ]; then
   echo ============================================
   echo 'Sync successfull'
   echo ============================================
else
   echo ============================================
   echo 'Sync failed'
   echo ============================================
   exit $?
fi
echo ============================================
echo 'Get prebuilts'
echo './vendor/cm/get-prebuilts'
echo ============================================
./vendor/cm/get-prebuilts
if [ $? -eq 0 ]; then
   echo ============================================
   echo 'Get prebuilts init successfull'
   echo ============================================
else
   echo ============================================
   echo 'Get prebuilts failed'
   echo ============================================
   exit $?
fi

