#!/bin/bash

ANDROID_NDK_ROOT=~/tools/android-ndk-r0d/
echo $ANDOID_NDK_ROOT

ANDROID_SDK="10 13 14 18 19 21"
BUILD_V="0"
BUILD_LOG="0"
BUILD_B=""
BUILD_CLEAN=""
for opt
do
  case $opt in
    ANDROID_SDK=*)
    ANDROID_SDK=${opt#ANDROID_SDK=}
    ;;
    V=*)
    BUILD_V=${opt#V=}
    ;;
    NDK_LOG=*)
    BUILD_LOG=${opt#NDK_LOG=}
    ;;
    -B)
    BUILD_B="-B"
    ;;
    clean*)
    BUILD_CLEAN=${opt}
    ;;
  esac
done

for i in $ANDROID_SDK
do
  echo "Compiling for API LEVEL($i)..............."
  ndk-build NDK_PROJECT_PATH=./out/$i \
            APP_BUILD_SCRIPT=./Android.mk \
            APP_PLATFORM=android-$i \
            ANDROID_SDK=$i \
            APP_ABI=armeabi-v7a \
            NDK_LOG=1 \
            NDK_ROOT_PATH=$ANDROID_NDK_ROOT \
            NDK_TOOLCHAIN_VERSION=4.9 \
            APP_STL=gnustl_static \
            V=$BUILD_V \
            NDK_LOG=$BUILD_LOG \
            $BUILD_B \
            $BUILD_CLEAN \
            -j8

#CXX_APP_STL=stlport_static \
#CXX_APP_STL=gnustl_static \
#APP_STL=stlport_shared\
#NDK_LOG=1 \
#V=1
done
