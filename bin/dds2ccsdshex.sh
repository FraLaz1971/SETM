#!/bin/bash
## this program handles all packet in a given input dds binary format file
# it takes as input the input dds file and the number of packets to process
# if there are no packets to process it stops
# this is a prototype for packet handling scripts
# for each packet in the input data files it decode dds/ccsds/pus header fields 
# and dumps Data Field to an ascii hex string
# setting DEBUG=1 gives a lot more info

. lib/pl_tm_lib
. lib/bbe_lib

DEBUG=0 # 
if [[ $# != 2 ]]
then
  debug "usage: $(basename $0) <infile.dds> <npackets>"
  debug "set DEBUG=1 to have more info"
  exit $E_BADARGS
else
  [[ $DEBUG == 1 ]] && debug "START OF PROGRAM"
  DEBUG=0 # 
  infile="$1"
  t="$2"
  dds_packet_start=0; ccsds_packet_start=18
  for i in $(eval echo {1..$t} )
  do
      current_packet_length=0; subs=FFFF
      DEBUG=1
      [[ $DEBUG == 1 ]] && debug "iteration $i dds_packet_start = $dds_packet_start infile = $infile"
      [[ $DEBUG == 1 ]] && debug "#######################"
      [[ $DEBUG == 1 ]] && debug "### START PACKET $i  ###"
      [[ $DEBUG == 1 ]] && debug "#######################"
      DEBUG=0
      current_packet_length=$(get_dds_hd_pktlen "$infile" $dds_packet_start)
      [[ $DEBUG == 1 ]] && debug "ccsds current_packet_length (hex) = $current_packet_length"
      #current_packet_length=$(bbe -s -b "8:4" "$1" | xxd -u | awk  'BEGIN{FS=":"} {print $2}' | awk  'BEGIN{FS="."} {print $1}' | sed -e "s/ //g")
      #dcurrent_packet_length contains the packet length of the ccsds payload as a decimal value, it may include a variable length part
      dcurrent_packet_length=$( hextodec $current_packet_length )
      #hextodec $current_packet_length
      [[ $DEBUG == 1 ]] && debug "ccsds current packet length (dec) = $dcurrent_packet_length"
      str1=$(echo bbe -s -b $ccsds_packet_start:$dcurrent_packet_length $infile ); [[ $DEBUG == 1 ]] && debug "$str1"
      ## following instruction dumps ccsds packet on a hex string
      hexstr=$(bbe -s -b $ccsds_packet_start:$dcurrent_packet_length $infile | bin/ccsdstohex -)
      # set the SSC
      # set the setSSC
      DEBUG=1
      [[ $DEBUG == 1 ]] && debug "hexstr = $hexstr"
      ###
      echo -e "$hexstr"
      ###
      subs=${hexstr:4:4}; [[ $DEBUG == 1 ]] && debug "setSSC_hex $subs";
      [[ $DEBUG == 1 ]] && debug "bSSC = $( dectobin $(( $(hextodec $subs) & $(hextodec "3FFF") )) )"
      setSSC_hex $subs
      DEBUG=0
      ## now set the secondary header time in the packet structure
      subs=${hexstr:20:8}; [[ $DEBUG == 1 ]] && debug "set_dfh_scet_coarse_hex $subs";
      set_dfh_scet_coarse_hex $subs
      subs=${hexstr:28:4}; [[ $DEBUG == 1 ]] && debug "set_dfh_scet_fine_hex $subs";
      set_dfh_scet_fine_hex $subs ;
            ## print scet seconds dec
      [[ $DEBUG == 1 ]] && debug "get_packet_time_secs = $(get_packet_time_secs)"
      ## print scet subseconds dec
      [[ $DEBUG == 1 ]] && debug "get_packet_time_subsecs = $(get_packet_time_subsecs)"
      ## following instruction print on stdout the values TIME (s), SSC
      ## only time secs for the moment
      ### print on stdout the ssc time series (time(s), SSC) [DISABLED]
      #echo -e "$(get_packet_time_secs) $SSC"
      debug "$(get_packet_time_secs) $SSC"
      [[ $DEBUG == 1 ]] && debug "printing ssc time series point (time(s), SSC) for given packet"
      ### comment here for not printing on stdout
      dds_packet_start=$(($dcurrent_packet_length + $ccsds_packet_start)); #update the offset
      #      dds_packet_start=$(( $dds_packet_end +  ))
      [[ $DEBUG == 1 ]] && debug "dds_packet_start = $dds_packet_start"
      ccsds_packet_start=$(($dds_packet_start+18))
      DEBUG=1
      [[ $DEBUG == 1 ]] && debug "#######################"
      [[ $DEBUG == 1 ]] && debug "### END PACKET $i    ###"
      [[ $DEBUG == 1 ]] && debug "#######################"
      DEBUG=0
  done
      [[ $DEBUG == 1 ]] && debug "just after the packets loop"
      [[ $DEBUG == 1 ]] && debug "END OF PROGRAM"
fi
# examples of run:
# NECPreport/2018-12-12_tm.dds contains ELENA packets
#
#bin/dds2ccsdshex.sh ~/Desktop/NECPreport/2018-12-12_tm.dds 20 2>/dev/null
#bin/dds2ccsdshex.sh indata/dds/2019-07-22_2pkts_tm.dds
#bin/dds2ccsdshex.sh indata/dds/2019-07-22_tm.dds 100  2>/dev/null | awk 'BEGIN{EPOCH=628509282}{print ($1-EPOCH),$2}' | graph -T ps -X "Time(s)" -Y "SSC" -L "Sequence Counter time series"  -h 0.7 -w 0.8 | okular -
# bin/script3_bbe.sh  indata/dds/2019-07-22_tm.dds 5  2> log/2019-07-22_tm_err.log; cat log/2019-07-22_tm_err.log  | grep "###"
