#!/bin/bash
# tests srn_tm_lib library
. lib/srn_tm_lib
np=10; tot=""
dump_dds_packet_file2 10
# for t in $(eval echo {1..$np}); 
# do 
# #  tot="$tot $(print_ccsds_packet2)"; 
#   dump_ccsds_packet2
# done
#echo $tot |  sed -e "s/ //g"
# rm out2.ccsds
# dump_ccsds_packet  > out2.ccsds 
# oneline=$(xxd -u out2.ccsds | awk 'BEGIN{FS=":"}{print $2}' | awk '{print $1 $2 $3 $4 $5 $6 $7 $8}' | awk 'BEGIN{FS="."}{print $1}')
# echo $oneline | sed -e 's/ //g

