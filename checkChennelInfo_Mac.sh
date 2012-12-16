#!/bin/bash

CHENNEL_DIR=$1
cd $CHENNEL_DIR
MANIFEST_FILE=$CHENNEL_DIR'/AndroidManifest.xml'
if [ -e $MANIFEST_FILE ]; then
    echo
    echo 'Parsing '$MANIFEST_FILE
    echo "--------------------------"

    VERSION_CODE=`grep  android:versionCode AndroidManifest.xml \
                  | sed -E 's/.[^"]+"([^"]+)".*/\1/'`
    VERSION_NAME=`grep  android:versionName AndroidManifest.xml \
                  | sed -E 's/.[^"]+"([^"]+)".*/\1/'`
    DEBUGABLE=`grep android:debuggable AndroidManifest.xml \
                  | sed -E 's/.[^"]+"([^"]+)".*/\1/'`
    CDX_CODE=`grep meta.*feeCode AndroidManifest.xml \
                  | sed -E 's/.*value="(.*)".*/\1/g'`
    echo 'Android Version Code: '$VERSION_CODE
    echo 'Android Version Name: '$VERSION_NAME
    echo 'Android Debuggable: '$DEBUGABLE
    echo 'DianXin Code: '
    grep meta.*feeCode AndroidManifest.xml \
                  | sed -E 's/.*value=".{36}(.{8}).*".*/    \1/g'
else
    echo "File AndroidManifest.xml is not exsit!"
fi

ANT_PROPERTIES=$CHENNEL_DIR'/ant.properties'
if [ -e $ANT_PROPERTIES ]; then
    echo
    echo 'Parsing '$ANT_PROPERTIES
    echo "--------------------------"

    echo `grep ^apk.channel.id   ant.properties`
    echo `grep ^apk.channel.name ant.properties`
else
    echo 'File '$ANT_PROPERTIES' is not exsit!'
fi

PROJECT_FILE=$CHENNEL_DIR'/.project'
if [ -e $PROJECT_FILE ]; then
    echo
    echo 'Parsing '$PROJECT_FILE
    echo "--------------------------"

    PROJECT_NAME=`grep name\>Fi.*  .project \
        | sed -E 's/\s//g' \
        | sed -E 's/[^>]+>(.*)<.*/\1/'`
    echo 'PROJECT_NAME: '$PROJECT_NAME
else
    echo 'File '$PROJECT_FILE' is not exsit!'
fi

JAVA_FILE=$CHENNEL_DIR'/src/org/cocos2dx/FishingJoy2/FishingJoy2.java'
if [ -e $JAVA_FILE ]; then
    echo
    echo 'Parsing '$JAVA_FILE
    echo "--------------------------"

    ADMOB_ID=`grep "priv.* strAdMobID"  $JAVA_FILE \
      | sed -E 's/\s//g' \
      | sed -E 's/.[^"]+"([^"]+)".*/\1/'`
    echo 'Admob ID: '$ADMOB_ID

    PUNCHBOX_ID=`grep "priv.* strPunchBoxID"  $JAVA_FILE \
      | sed -E 's/\s//g' \
      | sed -E 's/.[^"]+"([^"]+)".*/\1/'`
    echo 'PunchBox ID: '$PUNCHBOX_ID

    SECRETKEY=`grep "priv.* strSecretKey"  $JAVA_FILE \
      | sed -E 's/\s//g' \
      | sed -E 's/.[^"]+"([^"]+)".*/\1/'`
    echo 'SecretKey: '$SECRETKEY

    echo `grep "Wrapper.*LogEnable"  $JAVA_FILE \
        | sed -E 's/\s//g'`
else
    echo 'File '$JAVA_FILE' is not exsit!'
fi

MODULE_FILE=$CHENNEL_DIR'/jni/ModuleCustom_android.h'
if [ -e $MODULE_FILE ]; then
    echo
    echo 'Parsing '$MODULE_FILE
    echo "--------------------------"

    CHANNAL_ID=`grep "#def.*CHANNAL_ID" $MODULE_FILE \
        | sed -E 's/[^[:digit:]]+//g'`
    echo 'CHANNAL_ID: '$CHANNAL_ID

else
    echo 'File '$MODULE_FILE' is not exsit!'
fi

BUILD_NATIVE_FILE=$CHENNEL_DIR'/build_native.sh'
if [ -e $BUILD_NATIVE_FILE ]; then
    echo
    echo 'Parsing '$BUILD_NATIVE_FILE
    echo "--------------------------"
    grep "\$GAME_AN.*copyResByResolution.*" $BUILD_NATIVE_FILE
else
    echo 'File '$BUILD_NATIVE_FILE' is not exsit!'
fi

# debug version
#echo `grep android:versionCode AndroidManifest.xml \
#     | sed -E 's/\s//g'`
#echo `grep android:versionName AndroidManifest.xml \
#     | sed -E 's/\s//g' \
#     | sed -E 's/(.*)"an.*/\1/'` 
#echo `grep android:debuggable AndroidManifest.xml | sed -E 's/\s//g'`

