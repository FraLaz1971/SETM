set term x11
set xdata time
set datafile separator "|"
set xtics  norangelimit
set xtics   ()
set ytics  norangelimit
set ytics   ()
fulltime(col) = strftime("%Y-%m-%dT%H:%M:%.9S",column(col))
parttime(col) = strftime("%H:%M:%.3S",column(col))
x = 0.0
GPFUN_fulltime = "fulltime(col) = strftime(\"%d %b %Y\\n%H:%M:%.3S\",column(col))"
GPFUN_parttime = "parttime(col) = strftime(\"%H:%M:%.3S\",column(col))"
#plot "-" u (fulltime(1)):log(2) w lp
set format x "%s"
set yrange [1:8]
#set yrange [0:100000000]
plot "-" u :log(2) w lp
2015-05-07T11:56:47.581347232|1
2015-05-07T11:56:47.587414204|100
2015-05-07T11:56:47.605369559|1000
2015-05-07T11:56:47.614962678|10000
2015-05-07T11:56:47.622007987|100000
2015-05-07T11:56:47.629641639|1000000
2015-05-07T11:56:47.635893271|10000000
2015-05-07T11:56:53.961194671|100000000
e
pause -1
