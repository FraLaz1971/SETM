#!/bin/bash
# tests srn_tm_lib library
. lib/srn_tm_lib
set_default_dds_packet; 
check_dds_pkt_fields; 
SSC=20;
set_default_dds_packet;
check_dds_pkt_fields
SSC=40;
set_default_dds_packet;
check_dds_pkt_fields