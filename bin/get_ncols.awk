#!/usr/bin/awk -f

#example dummy function
# function myprint(num)
# {
#   printf "%6.3g\n", num;
# }

#prints on stdout the n. of fields of the first table row

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
  #printf "get_ncols: read line \"%s\" \n", $0 > "/dev/stderr"
  #print "get_ncols: this line is starting with hash and will be treated as a comment" > "/dev/stderr"
  #printf "get_ncols: comment line n. %d \n", N_REMS > "/dev/stderr"
  N_REMS++
} 
#the following rule will be executed for all fields of the row
! /^#/ && NF != 0 { 
  #print  "get_ncols: this line is starting with a normal char and will be treated as a data row" > "/dev/stderr"
  #printf "get_ncols: N_FIELDS, %d \n", NF > "/dev/stderr"
  #printf "get_ncols: this row has NF = %d \n", NF > "/dev/stderr"
  if(!bf){N_COLS=NF; bf=1}
  i = 1
  while (i <= NF) { # iterate on all fields/columns of the record/row
    #printf "%s-->r[%d]=%s ",ft[i], i, $i > "/dev/stderr"
    i++
  }
}	
END     { 
          printf "%d\n", N_COLS
         # print "get_ncols: - DONE -" > "/dev/stderr" 
} 
#example usage: awk -f bin/get_ncols.awk<data/dataset060.csv
#in the following way you suppress stderr out on screen
#example usage: awk -f bin/get_ncols.awk<data/dataset060.csv 2>/dev/null   
#in the following way capturing input from stdin
#echo "6,7,8, 21, 23, 56, 6, 7"  | awk -f bin/get_ncols.awk 2>/dev/null