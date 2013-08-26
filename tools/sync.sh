echo ============================================
echo 'Init sync CM10 with Github'
echo 'repo init -u git://github.com/CyanogenMod/android.git -b cm-10.2'
echo ============================================
repo init -u git://github.com/CyanogenMod/android.git -b cm-10.2
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
echo 'Sync CM10'
echo 'repo sync -f'
echo ============================================
repo sync -f -j16 -c
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

