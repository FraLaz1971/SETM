#!/usr/bin/gnuplot4.4
# plots a 2 x 3 pixel 2D image in x,y,val format
#set terminal wxt size 350,262 enhanced font 'Verdana,10' persist
set terminal wxt enhanced font 'Verdana,10' persist
set border linewidth 0
unset key
#unset colorbox
#unset tics
set title "plots matrix a 2x3 matrix with random values in range [0,100)"
set xrange [0:1]
set yrange [0:2]
set label "random matrix 2x3 image" offset 0, -2
plot 'image2X3.dat' matrix with image
pause -1