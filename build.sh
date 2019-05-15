#!/bin/bash

if [ -z "$ANDROID_OBJC_SDK_PATH" ]; then
    ANDROID_OBJC_SDK_PATH="$(pwd)/../../.."
fi

# create symlinks for private headers (need for CF and Foundation)


build_library() {
    INSTALL_PATH=$CURRENT_DIR/install
    cmake   -DANDROID_PLATFORM="android-$ANDROID_PLATFORM" \
            -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
            -DANDROID_ABI=$ARCH \
            -DBUILD_SHARED_LIBS=NO \
            -DENABLE_DISPATCH_INIT_CONSTRUCTOR=NO \
            -DCMAKE_TOOLCHAIN_FILE=$NDK/build/cmake/android.toolchain.cmake \
            -DCMAKE_SYSROOT=$NDK/toolchains/llvm/prebuilt/darwin-x86_64/sysroot \
            -DANDROID_STL=$ANDROID_STL \
            -DCMAKE_INSTALL_PREFIX=$INSTALL_PATH \
            -DCMAKE_INSTALL_LIBDIR=$ARCH \
            -G "Ninja" $CURRENT_DIR

}

did_build_library() {
    rm -rf $CURRENT_DIR/install/$ARCH
    mv $CURRENT_DIR/install/lib $CURRENT_DIR/install/$ARCH
}

source $ANDROID_OBJC_SDK_PATH/develop/scripts/buildLibraryUsingNinja.sh $@
