#!/bin/bash
# script to test pl_tm_lib library
# saves packet series to fiven filename
. lib/pl_tm_lib
DEBUG=1 # when in debug doesn't remove temp files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) > filename.dds"
  debug "set DEBUG=1 to have more info"
  exit $E_BADARGS
else
  [[ $DEBUG == 1 ]] && debug "START OF PROGRAM"
  SSC=10;
  set_dds_header
  dds_hd_gentime[63]=1
  set_ccsds_packet; 
  dump_dds_packet2
  SSC=20;
  set_dds_header
  dds_hd_gentime[62]=1
  dds_hd_gentime[63]=0
  set_ccsds_packet; 
  dump_dds_packet2
fi
# set_dds_header
# dds_hd_gentime[62]=1
# set_ccsds_packet; 
# dump_dds_packet2
# SSC=40;
# set_dds_header
# dds_hd_gentime[62]=1
# dds_hd_gentime[63]=1
# set_ccsds_packet; 
# dump_dds_packet2
