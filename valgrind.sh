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
for var in `ls | gerp callgrind`
do
        echo $var 
        gprof2dot -f callgrind -n10 -s $var > dot/$var.dot
        dot -Tsvg dot/$var.dot -o output/$var.svg
done


===================

valgrind --tool=callgrind --separate-threads=yes ./ffmpeg -i video.mp4 -vn -ar 44100 video.flv 
tar zcvf output.tar.gz output
