#!/bin/bash
# tests srn_tm_lib library
. lib/srn_tm_lib
SSC=20;
unset dfh; unset df; unset sdf
clean_current_packet
#set_ccsds_packet
set_ccsds_header
#hd_pktlen=(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) #set as a packet with the DFH + 1 bytes
dfh_service_type=(1 1 0 0 0 0 0 0)
dfh_service_subtype=(1 0 1 1 0 0 0 0)
print_ccsds_header
# rm out2.ccsds
# dump_ccsds_packet  > out2.ccsds 
# oneline=$(xxd -u out2.ccsds | awk 'BEGIN{FS=":"}{print $2}' | awk '{print $1 $2 $3 $4 $5 $6 $7 $8}' | awk 'BEGIN{FS="."}{print $1}')
# echo $oneline | sed -e 's/ //g

