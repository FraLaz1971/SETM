#!/bin/bash
. srn_tm_lib

#echo $(getEvtFlag $2)
#echo $(getEvtFlag2 $2)
ARG=2
E_ERR_ARG=65
if [ $# -ne "$ARG" ] # check on the number of parameters passed to the function
then
  echo "usage: extract_timemark_event <hexword1> <hexword2>"
  exit $E_ERR_ARG
else 
   dflag=$(bintodec $(getEvtFlag $2))
   if [[ $dflag -eq 1 ]]
   then 
#     p1=$(getSecPart1 $1)
#     p2=$(getSecPart2 $2)
#     printf "%016d\n" $(hextobin $1)
#     echo $p1
#     printf "%016d\n" $(hextobin $2)
#     echo $p2
#     printf "%016d\n" $(dectobin $(( $(bintodec $p1) + $(bintodec $p2) )))
#     ss=$(getSubSecs $2)
    echo "this is a time marker event"
   else
    echo "this is not a time marker event: it's a data event"
   fi
fi 

