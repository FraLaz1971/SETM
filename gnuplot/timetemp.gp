#
# $Id: timetemp.gp,v 1.1.1.1 2019-02-08 13:08:31 colombocvs Exp $
#
#set terminal
set timestamp "%d/%m/%y %H:%M" offset 80,-2 font "Helvetica" 
set title "plot with time as x-values"
#set style data fsteps
set xlabel "Time (s)"
set timefmt "%b%d%H:%M:%S"
set yrange [50:80]
set xdata time
set ylabel "Temperature (°C)"
set format x "%b-%dT%H:%M:%S"

#set xtics rotate by 90 offset 0,-4 out nomirror
set xtics rotate by 90 offset 0,-4 out nomirror
#set format x "%b%d%k:%M:%S" timedate
#set format x "%H:%M:%S" time
#set xrange [ "Jan3117:00:00":"Jan3118:10:00" ]
#show format
#set grid
#set key left
#set xtics rotate by 90 offset 0,-4 out nomirror
#plot 'mytt.dat' using 1:4 t 'temperature data'  with lp 
plot '~/test_temperature1.dat' using 1:4 t 'temperature data'  with lines 
#, \
#      'timedat.dat' using 1:3 t 'Total P' with points, \
#      'timedat.dat' using 1:4 t '', \
#      'timedat.dat' using 1:4 t 'PO4'\ 

#pause 255 "Hit return to continue"

# reset
# 
# set title "Time data on Y, millisecond precision" font ",14"
# set ydata time
# set timefmt "%s"
# set offset 0.5,1.5,.2,.2
# unset key
# 
# fulltime(col) = strftime("%d %b %Y\n%H:%M:%.3S",column(col))
# parttime(col) = strftime("%H:%M:%.3S",column(col))
# 
# plot '-' using 0:1:(fulltime(1)):xticlabels(2):yticlabels(parttime(1)) \
#          with labels point pt 7 left offset 1,1 font ",7"
# 1390852607.1	A
# 1390852607.2	B
# 1390852607.4	C
# 1390852607.8	D
# 1390852608.4	E
# 1390852610.001	F
# e
# 
# pause -1 "Hit return to continue"
# 
# reset
# set title "Date format (top) vs Time format (bottom)" font "/:Bold,14"
# set xrange [-7000:3000]
# set link x2
# set tics font ",8"
# set x2tics format "%D\n%R" time offset 0,-1
# set xtics format "%tH:%tM:%tS" time
# set xlabel 'set xtics format "%tH:%tM:%.2tS"' font "/:Bold"
# set arrow 1 from 0, graph 0 to 0, graph 1 heads filled
# 
# set yzeroaxis
# unset ytics
# set bmargin at screen .55
# set tmargin at screen .6
# 
# plot x notitle
# 
# pause -1 "Hit return to continue"
 
#reset
