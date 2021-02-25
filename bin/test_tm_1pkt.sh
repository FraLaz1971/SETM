#!/bin/bash
# tests srn_tm_lib library
. lib/srn_tm_lib
SSC=20;
unset df; unset sdf
hd_pktlen=(0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 1) #set as a packet with the DFH + 2 bytes 
debug "header version and identification section bitarray = ${hd_vid[*]} "
debug "header sequence control section bitarray = ${hd_seq[*]} "
debug "header packet length bitarray = ${hd_pktlen[*]} "
debug "dec. value of the packet length field = $(bitvectodec ${hd_pktlen[*]}) "
# set_ccsds_packet
#fill_random_sdf 2
#set_ccsds_packet_length 12
# check_ccsds_pkt_fields
set_ccsds_packet
check_ccsds_pkt_compliance
dump_ccsds_packet

# unset df; unset sdf
# # set_ccsds_packet
# hd_pktlen=(0 0 0 0 0 0 0 0 0 0 0 0 1 0 1 0) #set as a packet with the DFH + 1 byte 
# debug "header version and identification section bitarray = ${hd_vid[*]} "
# debug "header sequence control section bitarray = ${hd_seq[*]} "
# debug "header packet length bitarray = ${hd_pktlen[*]} "
# debug "dec. value of the packet length field = $(bitvectodec ${hd_pktlen[*]}) "
# fill_random_df 11
# debug "df size is = ${#hd_pktlen[*]} df bitvec is ${hd_pktlen[*]} "
# debug "3) get_df_len_bytes = $get_df_len_bytes"
# set_ccsds_packet_length 11
# debug "4) get_df_len_bytes = $get_df_len_bytes (after ) set_ccsds_packet_length 11"
# # check_ccsds_pkt_fields
# set_ccsds_packet
# check_ccsds_pkt_compliance
# dump_ccsds_packet

