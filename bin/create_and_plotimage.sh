#!/bin/bash
##############################################
# written by francesco lazzarotto 2015-05-08 #
# francesco.lazzarotto@iaps.inaf.it          #
# creates an NxM ascii matrix and plots	     #
# it on with gnuplot			     #
##############################################
. funtest
. ef # include elena functions library file
DEBUG=1 # when in debug doesn't remove temp files
if [[ $# -ne 2 ]]
then
  debug "usage: $(basename $0) <nrows> <ncols>"
  exit $E_BADARGS
else
  is_int $1 && is_int $2 || { debug "input args $1 and $2 MUST be legal decimal integers!"; exit $EX_DATAERR; }
  (( $1 > 0)) && (($2 > 0)) || { debug "input args $1 and $2 MUST be > 0 integers values !"; exit $E_ARGSLIMITS; }  
  tempf=$(mktemp --suffix="_$1"X"$2""_image.dat")
  debug "executing createImage $* >> $tempf"
  createImage $1 $2 gnuplot >> "$tempf";
  debug "created image on file $tempf"
  plotImage "$tempf" $1 $2
  [[ "$DEBUG" == "0" ]] && remove_tempfile "$tempf"
  [[ "$DEBUG" == "1" ]] || debug "$tempf has not been removed"
fi
