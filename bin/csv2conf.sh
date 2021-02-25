#!/bin/bash
. lib/csv_lib

DEBUG=0 # when in debug prints more log files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <filename> "
  debug "creates a csv output file"
  exit $E_BADARGS
else
  debug "start"
  basef=$(echo "$1" | cut -d . -f 1)
  DOUTFILE="$basef".csv
  COUTFILE="$basef".conf
  N_FIELDS=3; 
  set_names Time temp1 temp2; 
  set_units s degC degC; 
  set_types int int int; 
  set_sizes 4 2 2;
  push_comment "#this is a comment"
  push_comment "#this is another comment"
  push_record "1 ,2, 3"; 
  push_record "6,7,8";
  debug "going to create dataset files for a $N_FIELDS column table"
  print_metadata $N_FIELDS $COUTFILE; 
  print_comments $DOUTFILE;
  print_data $DOUTFILE;
  debug "printing generated metadata file $DOUTFILE"
  cat $COUTFILE;
  debug "printing generated data file $DOUTFILE"
  cat $DOUTFILE;
  report
fi #check on correct number of input arguments

