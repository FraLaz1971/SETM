set xdata time
set timefmt "%b %d %H:%M:%S %Y"
#set format x "%H/%a"
set format x "%b-%d"
plot "-" u 1:5 w lp
    Aug 2 17:00:09 2011 1
    Aug 3 02:00:09 2011 2
    Aug 4 22:00:09 2011 3
    Aug 5 04:00:09 2011 4
    e
pause 1
reset
set xdata time
set timefmt "%b%d%H:%M:%S"
set format x "%M:%S"
set xrange [ "Jan3116:15:00" : "Jan3116:40:00" ]
plot "-" u 1:4 w lp
Jan3116:16:24 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:25 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:26 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:27 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:28 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:29 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:30 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:31 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:32 localhost lmsensors/acpitz-virtual-0/temp1: 71
Jan3116:16:33 localhost lmsensors/acpitz-virtual-0/temp1: 72
e
pause 1
reset
set xdata time
set timefmt "%Y-%m-%dT%H:%M:%S"
set xrange [ "2015-05-07T11:56:00.0" : "2015-05-07T11:57:00.0" ]
show xrange
#set xrange restore
set yrange [ 3 : 5 ]
set format x "%M:%S"
set datafile separator "|"
plot "-" u :2 w lp 
2015-05-07T11:56:47.581347232|4|gesh|INFO|created reversed histo data file (histogram on columns) in /tmp/tmp.ezfzsm94go_on_cols.dat
2015-05-07T11:56:47.587414204|4|gesh|INFO|removing histogram on rows data file in /tmp/tmp.EouvruJ7J8_on_rows.dat
2015-05-07T11:56:47.605369559|4|gesh|INFO|./gehs.sh: creating temp gnuplot script on file /tmp/tmp.UAGXN3MYWI.gp
2015-05-07T11:56:47.614962678|4|gesh|INFO|awk output is 4
2015-05-07T11:56:47.622007987|4|gesh|INFO|gnuplot script generated
2015-05-07T11:56:47.629641639|4|gesh|INFO|created gnuplot temp script in /tmp/tmp.UAGXN3MYWI.gp
2015-05-07T11:56:47.635893271|4|gesh|INFO|running gnulplot
2015-05-07T11:56:53.961194671|4|gesh|INFO|removing gnuplot temp script in /tmp/tmp.UAGXN3MYWI.gp
e