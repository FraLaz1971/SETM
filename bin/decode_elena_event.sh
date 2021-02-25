#!/bin/bash
. srn_tm_lib

#echo $(getEvtFlag $2)
#echo $(getEvtFlag2 $2)
#decodeELNevt
ARG=3
E_ERR_ARG=65
if [ $# -ne "$ARG" ] # check on the number of parameters passed to the function
then
  echo "usage: decode_elena_event <hexword1> <evt Part2 (hex)> <evt flag (hex)>"
  exit $E_ERR_ARG
else 
   w2x=$(getSecondWord $2 $3)
   decodeELNevtX $1 $w2x
#   dflag=$(bintodec $(getEvtFlag $2))
#   if [[ $dflag -eq 0 ]]
#   then 
#     echo "this is a time marker event"
#   else
#     echo "this is not a time marker event: it's a data event"
#   fi
fi 

