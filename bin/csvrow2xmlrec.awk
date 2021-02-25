#!/usr/bin/awk -f
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
  FS=","; DEBUG=0
  print "cvsrow2xmlrec: converting csv row in xml record" > "/dev/stderr"
  print "cvsrow2xmlrec: writing result on stdout" > "/dev/stderr"
  # read metadata from conf file
  ft[1]="Time"; ft[2]="Temp1"; ft[3]="Temp2";
  if (DEBUG==1) printf "ft[1]=%s\n", ft[1] > "/dev/stderr"
} 
#do not process lines starting with hash #
/^#/    {
  if (DEBUG==1) printf "cvsrow2xmlrec: read line \"%s\" \n", $0 > "/dev/stderr"
  if (DEBUG==1) print "cvsrow2xmlrec: this line is starting with hash and will be treated as a comment" > "/dev/stderr"
} 

#the following rule will be executed for all fields of the row

! /^#/ && NF != 0 { 
if (DEBUG==1) print  "cvsrow2xmlrec: this line is starting with a normal char and will be treated as a data row" > "/dev/stderr"
  DEBUG=1
  if (DEBUG==1)  printf "cvsrow2xmlrec: N_FIELDS, %d \n", NF > "/dev/stderr"
  DEBUG=0
  if (DEBUG==1)  printf "cvsrow2xmlrec: this row has NF = %d \n", NF > "/dev/stderr"
  i = 1
  openTag("RECORD");
   while (i <= NF) {
#     if (i=1) tv=ft[$i]
     if (DEBUG==1) printf "%s-->r[%d]=%s ",ft[i], i, $i > "/dev/stderr"
       openTag($i);printf("N");closeTag($i)
    i++
   }
  print " \n"
  closeTag("RECORD")
  if (DEBUG==1) print "cvsrow2xmlrec:", $1, "\t", $2, "\t", $3 > "/dev/stderr"
}	

END     { print " - DONE -" > "/dev/stderr" } 
          