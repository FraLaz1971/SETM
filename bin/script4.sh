#!/bin/bash
## this program tests thee SSC extraction
## given the 2 BYTES of the seq section of the ccsds header
. lib/srn_tm_lib
. lib/bbe_lib

DEBUG=0 # when in debug doesn't remove temp files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <seq hexstring>"
  exit $E_BADARGS
else
  dds_packet_start=0; ccsds_packet_start=18
      hexstr=$1
      # set the SSC
      #subs=${hexstr:4:4}
      naddbits=0
      vec=( $(hextobitvec $hexstr) ) # bit vector containing the ssc value
      abs="";
      nbit=$(( $(hextobitvec $hexstr | wc -c)/2 )); 
      if [ "$nbit" -le 14 ] && [ "$naddbits" -ge 0 ] 
      then 
        naddbits=$((14 - $nbit)); 
        if [ "$naddbits" -gt 0 ]
        then
          for s in $(eval echo {1..$naddbits}); 
          do 
            abs="0 "$abs;
            [[ $DEBUG == 0 ]] && debug "iteration $s"
          done;
        fi
      elif  [ "$nbit" -gt 14 ] && [ "$nbit" -lt 17 ]
      then
        debug "nbit = $nbit"
        i=$(( $nbit - 14))
        while [ "$i" -lt $nbit ]
        do
          [[ $DEBUG == 1 ]] && echo "index $(( $i))"
          debug "put index $(( $i )) "
          ### <---
          debug "hd_seq_ssc[$i]=${vec[$i]}"
          #hd_seq_ssc[$i]=${vec[$i]}
          i=$(( $i + 1 ))
          ### <---
        done
      fi
      debug "vec = $(echo ${vec[@]})"
      debug "given hex string $1 is composed by $nbit bits, i have to add $naddbits bits"
      debug "abs = $abs""bit array      --> $(hextobitvec $hexstr)"
      debug "complete bit array is -> $abs$(hextobitvec $hexstr)"
      subs=$hexstr
      setSSC_hex $subs
      debug "getSSC $(getSSC) (hex) $( bitvectodec $(getSSC)) (dec)"
fi

