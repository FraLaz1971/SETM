#!/bin/bash
. lib/utils_lib

DEBUG=0 # when in DEBUG=1 prints more log messages
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <infile.csv> "
  exit $E_BADARGS
else
    DEBUG=0 # when in DEBUG=1 prints more log messages
    [[ $DEBUG = 1 ]] && debug "### START OF PROGRAM ###"
    [[ $DEBUG = 1 ]] && debug "hello bepi!! reading input from file $1"
    if test -f ; then echo "file $1 is present"; ls -alhrt "$1"; else echo "file $1 is not present"; fi
    [[ $DEBUG = 1 ]] && debug "### END OF PROGRAM ###"
    DEBUG=0 # when in DEBUG=1 prints more log messages
fi

