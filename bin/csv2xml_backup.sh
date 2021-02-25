#!/bin/bash
# /*
#  * @file csv2xml_backup.sh
#  * @brief executable bash script that converts csv files to xml simple 
#  * part of the bash library, suitable for science research
#  * containing sw tools to be used in the P/L experiments
#  * onboard the ESA/JAXA BepiColombo space mission 
#  * http://sci.esa.int/bepicolombo
############################################
## this version contains the awk script   ## 
## embedded in the bash script file       ##
############################################
#  * @copyright (C) 2019 GPL 2 free software license 
#  * @author Francesco Lazzarotto (INAF - OAPD) Francesco.lazzarotto@inaf.it
#  * 
#  * This program is free software; you can redistribute it and/or modify
#  * it under the terms of the GNU General Public License as published by
#  * the Free Software Foundation; either version 2 of the License, or
#  * (at your option) any later version. (GPL-2.0-or-later)
#  * 
#  * This program is distributed in the hope that it will be useful,
#  * but WITHOUT ANY WARRANTY; without even the implied warranty of
#  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  * GNU General Public License for more details.
#  * 
#  * You should have received a copy of the GNU General Public License along
#  * with this program; if not, write to the Free Software Foundation, Inc.,
#  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#  * 
#  * library definition to be sourced from a main program/script
#  */

. lib/errvals
. lib/utils_lib
. lib/xml_lib

# records related variables
N_REMARKS=0 #n. of comment lines in the input file (inizialisation)
N_RECORDS=0 #n. of data lines/records in the file (inizialisation)
REMARKS[0]=""; remcnt=0; # index for iterating on the comments header
RECORDS[0]=""; reccnt=0; # index for iterating on the data lines

#fields related variables
N_FIELDS=0 #n. of data fields in one record for this file (inizialisation)


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
    #debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR"
     #debug "line = $line"
     if [[ ${line:0:1} == "#" ]] 
     then
       REMARKS[$BNR]=$line
       debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR->comment";
     else
       RECORDS[$BNDR]=$line
       # extract metadata
       # set the number of fields for each record record
       debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR->normal line"
                 echo "$line" |  awk '
          function myprint(num)
          {
            printf "%6.3g\n", num;
          }
          
          function putDeclaration(){
            print "<?xml version=\"1.0\"?>";
          }

          function openTag(val){
            printf "<%s>", val
          }

          function closeTag(val){
            printf "</%s>", val
          }

          function emptyTag(val){
            openTag(val); closeTag(val)
          }

          function autoTag(val){
            printf "<%s/>", val
          }

          function comment(val){
            printf "<!--%s-->", val
          }

          BEGIN   { 
                    FS=","
                    print "cvsrow2xmlrec: converting csv row in xml record" > "/dev/stderr"
                    print "cvsrow2xmlrec: writing result on stdout" > "/dev/stderr"
                    ft[1]="Time"; ft[2]="Temp1"; ft[3]="Temp2";
                    #printf "ft[1]=%s\n", ft[1]
                  } 
                  # do not process lines starting with hash #
          /^#/    {
                    printf "cvsrow2xmlrec: read line \"%s\" \n", $0 > "/dev/stderr"
                    print "cvsrow2xmlrec: this line is starting with hash and will be treated as a comment" > "/dev/stderr"
                  } 
                  #the following rule will be executed for all fields of the row
          !/^#/ && NF != 0 { 
                  printf "N_FIELDS, %d \n", NF > "/dev/stderr"
                  printf "cvsrow2xmlrec: this row has NF = %d ", NF > "/dev/stderr"
                  i = 1
                  openTag("HKsample")
                  while (i <= NF) {
                    #if (i=1) tv=ft[$i]
                    #printf "%s-->r[%d]=%s ",ft[i], i, $i 
                    openTag(ft[i]);printf("%s", $i);closeTag(ft[i])
                    i++
                  }
                  closeTag("HKsample")
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
