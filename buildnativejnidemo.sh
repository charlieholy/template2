#!/bin/bash
set -e
export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/include/darwin:/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/include
CLASS=NativeDemo
PKG=com/charlie/ko
CLASSOUT=classout
MF=$CLASSOUT/META-INF/MANIFEST.MF
JNIOUT=jni
OUTJAR=nativedemo.jar
NATIVE=com_charlie_ko_NativeDemo

init()
{
rm -rf $MF $PKG $CLASSOUT $JNIOUT $OUTJAR
#exit 0
mkdir -p $PKG $CLASSOUT $JNIOUT $CLASSOUT/META-INF
cat > $PKG/$CLASS.java <<EOF
package com.charlie.ko;
import java.io.File;
public class NativeDemo {
	{
	File f = new File("NativeDemo.so");
	String so =f.getAbsolutePath();
	System.out.println("so path:"+so);
	System.load(so);
	//System.loadLibrary("NativeDemo.so");
	}
	public native void sayHello(); 
	public static void main(String[]args) {
		System.out.println();
		new NativeDemo().sayHello();
	}
}
EOF
echo $PKG/$CLASS.java > src.txt
javac -d $CLASSOUT @src.txt 
echo javah $PKG/$CLASS
echo com.charlie.ko.NativeDemo > class.txt
javah -d $JNIOUT -cp $CLASSOUT -jni @class.txt
cat > $JNIOUT/$NATIVE.cpp <<EOF
#include <$NATIVE.h>
#include <iostream>
using namespace std;
JNIEXPORT void JNICALL Java_com_charlie_ko_NativeDemo_sayHello
  (JNIEnv *, jobject)
{
  cout << "hello native" << endl;
  return ;
}
EOF
cat > $MF <<EOF
Manifest-Version: 1.0
Created-By: 1.8.0_272 (PrivateBuild)
Main-Class: com.charlie.ko.NativeDemo
EOF
}
#init
g++ -fPIC -shared -Ijni $JNIOUT/$NATIVE.cpp -o $CLASS.so
cd $CLASSOUT
	jar -cvfm $OUTJAR META-INF/MANIFEST.MF .
cd -
java -jar $CLASSOUT/$OUTJAR





