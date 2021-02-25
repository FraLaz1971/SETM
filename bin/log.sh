#!/bin/bash
. lib/utils_lib
#   $1       $2,      $3,       $4,     $5,   
# logfile severity, subsystem, module, message
if [[ $# -lt 5 ]]
then
  debug "usage: $(basename $0) <logfile> <severity> <subsystem> <module>  <text_message> "
  exit $E_BADARGS
else
DEBUG=0 # when in debug prints more log files
    debug "### START OF PROGRAM ###"
    lf="$1"; sv="$2"; su="$3"; mo="$4"; 
    shift 4
    msg="$@"
    bclogx  "$lf" "$sv" "$su" "$mo" "$msg" 
    debug "### END OF PROGRAM ###"
DEBUG=0 # when in debug prints more log files
fi

