#!/bin/bash
# tests srn_tm_lib library
. lib/srn_tm_lib
SSC=20;
fill_random_df 96
set_ccsds_packet_length 12
check_dds_pkt_fields
check_ccsds_pkt_compliance
SSC=40;
fill_random_df 88
set_ccsds_packet_length 11
check_dds_pkt_fields
check_ccsds_pkt_compliance
