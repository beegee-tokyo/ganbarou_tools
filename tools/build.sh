/home/beegee_tokyo/Omni-4.4/prebuilts/misc/linux-x86/ccache/ccache -M 10G
export USE_CCACHE=1
. build/envsetup.sh
lunch full_jfltexx-userdebug
make otapackage