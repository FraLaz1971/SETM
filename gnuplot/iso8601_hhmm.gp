reset
clear
set key off
set title "HH:MM versus Date (xdata is time)"

# Setting xdata to time precludes the use of histograms.
set xdata time
set timefmt "%Y-%m-%d"

# set format x controls the way that gnuplot displays the dates on the x axis.
# "%Y-%m-%d" is the same as "%F", but "%F" applies to output only; it won't work
# for timefmt, which controls data reading.
set format x "%Y-%m-%d"

# out draws the tic marks on the outside of the border; otherwise they'd be
# obscured by the boxes.
set xtics rotate by 90 offset 0,-4 out nomirror

# Impulses are rather thin by default, so thicken them up with linewidth.
plot "iso8601_hhmm.tsv" using 1:2 with impulses linewidth 10

