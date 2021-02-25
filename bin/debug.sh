#!/bin/bash
. bin/utils_lib

DEBUG=0 # when in debug prints more log files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <infile.csv> "
  exit $E_BADARGS
else
    debug "### START OF PROGRAM ###"
    debug "### END OF PROGRAM ###"
fi

