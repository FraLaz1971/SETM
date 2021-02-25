#!/usr/bin/awk -f
function myprint(num)
{
  printf "%6.3g\n", num;
}

BEGIN   { 
  FS=","
  N_REMS=0
  N_ROWS=0
  bf=0
  #  N_COLS=0
  print "get_ncols: retrieving the number of columns in a csv table" > "/dev/stderr"
  print "get_ncols: writing result on stdout" > "/dev/stderr"
} 
#do not process lines starting with hash #
/^#/    {
  printf "get_ncols: read line \"%s\" \n", $0 > "/dev/stderr"
  print "get_ncols: this line is starting with hash and will be treated as a comment" > "/dev/stderr"
  N_REMS++
} 
#the following rule will be executed for all fields of the row
! /^#/ && NF != 0 { 
  print  "get_ncols: this line is starting with a normal char and will be treated as a data row" > "/dev/stderr"
  printf "get_ncols: N_FIELDS, %d \n", NF > "/dev/stderr"
  printf "get_ncols: this row has NF = %d \n", NF > "/dev/stderr"
  if(!bf){N_COLS=NF; bf=1}
  i = 1
  while (i <= NF) { # iterate on all fields/columns of the record/row
    printf "%s-->r[%d]=%s ",ft[i], i, $i > "/dev/stderr"
    i++
  }
}	
END     { 
          printf "N_REMS%s %d\n", FS,N_REMS
          printf "N_ROWS%s %d\n", FS,NR
          printf "N_COLS%s %d\n", FS,N_COLS
          print "get_ncols: - DONE -" > "/dev/stderr" 
} 
#example usage: awk -f bin/get_ncols.awk<data/dataset060.csv          