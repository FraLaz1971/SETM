#!/bin/bash
## this program converts packet files in the dds binary format to the ccsds raw source binary format 
# (without any additional header). it takes as input the input dds file and the number of packets to process
# if there are no packets to process it stops
# this is a prototype for packet handling scripts

. lib/srn_tm_lib
. lib/bbe_lib

DEBUG=0 # when in debug doesn't remove temp files
if [[ $# != 2 ]]
then
  debug "usage: $(basename $0) <infile.dds> <npackets> [> outfile.ccsds]"
  exit $E_BADARGS
else
  infile="$1"
  t="$2"
  dds_packet_start=0; ccsds_packet_start=18; dds_header_length=18;
  for i in $(eval echo {1..$t} )
  do
      current_packet_length=0
      debug "iteration $i dds_packet_start = $dds_packet_start infile = $infile"
      current_packet_length=$(get_dds_hd_pktlen "$infile" $dds_packet_start)
      debug "1) current_packet_length = $current_packet_length"
      #current_packet_length=$(bbe -s -b "8:4" "$1" | xxd -u | awk  'BEGIN{FS=":"} {print $2}' | awk  'BEGIN{FS="."} {print $1}' | sed -e "s/ //g")
      dcurrent_packet_length=$( hextodec $current_packet_length )
      #hextodec $current_packet_length
      debug "current packet length = $dcurrent_packet_length"
      str1=$(echo bbe -s -b $ccsds_packet_start:$dcurrent_packet_length $infile ); debug "$str1"
      bbe -s -b $ccsds_packet_start:$dcurrent_packet_length $infile
      dds_packet_start=$(($dcurrent_packet_length + $ccsds_packet_start)); #update the offset
#      dds_packet_start=$(( $dds_packet_end +  ))
      debug "dds_packet_start = $dds_packet_start"
      ccsds_packet_start=$(($dds_packet_start+$dds_header_length))
  done
fi

