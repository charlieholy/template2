cd android/contrib
./compile-ffmpeg.sh arm64
cd -
cd android
./compile-ijk.sh arm64
cd -

mod ijkplayer-example build.gradle
    productFlavors {
        //all32 { minSdkVersion 9 }
        all64 { minSdkVersion 21 }
        // armv5 {}
        // armv7a {}
        arm64 { minSdkVersion 21 }
        // x86 {}
    }
    dependencies {
    compile fileTree(include: ['*.jar'], dir: 'libs')
    compile 'com.android.support:appcompat-v7:23.0.1'
    compile 'com.android.support:preference-v7:23.0.1'
    compile 'com.android.support:support-annotations:23.0.1'

    compile 'com.squareup:otto:1.3.8'

    compile project(':ijkplayer-java')
    compile project(':ijkplayer-exo')
    all64Compile project(':ijkplayer-arm64')
    }


mod Android.mk
-O3==>-g -O0 
-DNDEBUG==>-DDEBUG
