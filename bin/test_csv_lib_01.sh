#!/bin/bash

. lib/errvals
. lib/utils_lib
. lib/xml_lib

REMARKS[0]=""; remcnt=0; # index for iterating on the comments header
RECORDS[0]=""; reccnt=0; # index for iterating on the data lines

DEBUG=0 # when in debug prints more log files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <infile.csv> "
  exit $E_BADARGS
else
  putDeclaration
  comment "csv2xml.sh converts csv tables into xml tables"
  openTag "HK"
  infile="$1"
  #BNR = number of csv records/lines in bash,  BNDR = n. of data records
  BNR=0; BNDR=0
{
  while read line 
  do           # for all lines of input file ... do something on the line elements
    #echo "processing line BNR = $BNR content $line, first char ${line:0:1} BNDR = $BNDR"
    debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR"
     if [[ ${line:0:1} == "#" ]] 
     then
       REMARKS[$BNR]=$line
       debug "comment";
     else
       RECORDS[$BNDR]=$line
       debug "normal line"
                 echo "$line" |  awk '
          function myprint(num)
          {
            printf "%6.3g\n", num;
          }
          
                  print " \n"
                  #print $1, "\t", $2, "\t", $3
                  }	
          END     { print " - DONE -" > "/dev/stderr" } 
          '
       BNDR=$(( $BNDR+1 ))
      fi
        BNR=$(( $BNR+1 ))    
        done # close loop on input csv file lines/records
      }<"$infile"

      closeTag "HK"

fi #check on correct number of input arguments

report(){
  debug "processed file: $infile"
  debug "tot n. of lines: $(($BNR-1))"
  debug "n. of data records: $(($BNDR-1))"
}

#print all read lines in the comments
print_remarks(){
  i=0
  MAX=$(( ${#REMARKS[*]} - 1 ))
  for i in  $(  eval echo  {0..$MAX})
  do
    echo "REMARKS[$i] = ${REMARKS[$i]}"
  done
}
#print all data records/row of the read csv file
print_data(){
  i=0
  MAX=$(( ${#RECORDS[*]} - 2 ))
  for i in  $(  eval echo  {0..$MAX})
  do
    echo "RECORDS[$i] = ${RECORDS[$i]}"
  done
}

print_metadata(){
  :
}

# report
# print_remarks
# print_data
# print_metadata
# 
#example usage: bin/csv2xml.sh indata/csv/test_utils_input_01.csv
