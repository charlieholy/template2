#!/bin/bash
gradle tasks --list
gradle :entry:clean --info

#gradle 插件安装路径 caches/modules-2
jad -o -r -ff -dtest -sjava -sjava structs2-core/**/*.class