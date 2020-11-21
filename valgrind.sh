prepare:

conda create -n py27 python=2.7
source activate py27
yum install graphviz
pip install pydot
pip install gprof2dot

=========================================================================
runtime:

valgrind --tool=callgrind ./pgs_bin
valgrind --tool=callgrind --separate-threads=yes ./pgs_bin

==============================================================================
results


python gprof2dot.py -f callgrind -n10 -s callgrind.out.31113 > valgrind.dot

dot -Tsvg valgrind.dot -o valgrind.svg


=================================================================================
batch transfer


#!/bin/bash
rm -rf output dot
mkdir output dot
for var in `ls | grep callgrind`
do
        echo $var 
        gprof2dot -f callgrind -n10 -s $var > dot/$var.dot
        dot -Tsvg dot/$var.dot -o output/$var.svg
done
tar zcvf output.tar.gz output

===================
compile ffmpeg with debug info

#!/bin/bash
./configure \
    --prefix=`pwd`/output \
    --enable-debug=3 \
    --disable-optimizations \
    --disable-stripping \
    --disable-x86asm


========================

valgrind --tool=callgrind --separate-threads=yes ./ffmpeg -i video.mp4 -vn -ar 44100 video.flv 

