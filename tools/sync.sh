echo ============================================
echo 'Init sync with Github'
echo 'repo init -u https://github.com/NamelessRom/android.git -b android-4.4'
echo ============================================
repo init -u https://github.com/NamelessRom/android.git -b android-4.4
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
echo 'Sync'
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
