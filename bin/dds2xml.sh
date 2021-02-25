#!/bin/bash
## this program dds2xml.sh handles all packet in a given input dds binary format file
# it takes as input the input dds file and the number of packets to process
# if there are no packets to process it stops
# this is a prototype for packet handling scripts
# for each packet in the input data files it decode dds/ccsds/pus header fields 
# # and dumps the input packets data into the xml format
# setting DEBUG=1 gives a lot more info
#  dds2xml.sh
#  input: dds packets binary file
#  output: xml file 
#  following part to be corrected
#  containing a table with the following elements:
#  pktid, ddsheadhex, ccsdshex
#  where pktid = a progressive n., id of the processed packet (int 4 BYTES)
#  ddsheadhex = an ascii hex string containing the ascii hex values of the dds header (string(36))
#  ccsdshex = an ascii hex string containing the ascii hex values of the packet, ccsds HD + DFH + DF (string(8192)
### TODO: add func. processing all packets if npackets = -1

. lib/pl_tm_lib
. lib/bbe_lib
. lib/xml_lib

set_caller_local(){
  set_pipeline_name "dds2xml"; set_calling_module "main"
}

DEBUG=1 # when in debug doesn't remove temp files
if [[ $# != 2 ]]
then
  debug "usage: $(basename $0) <infile.dds> <npackets> > outfile.xml "
  debug "set DEBUG=1 to have more info"
  exit $E_BADARGS
else
  set_log_filename #initialise logfile to be written during the execution
  set_caller_local
  [[ $DEBUG == 1 ]] && bclog "START OF PROGRAM"
  infile="$1"; declare -i pktcount; pktcount=1
  t="$2"
  dds_packet_start=0; ccsds_packet_start=18
  ### fixed length part of the xml output
  putDeclaration
  openTag "ResponsePart"
  indent 2 ;openTag "Response"
  indent 4 ;openTag "PktRawResponse"
  for i in $(eval echo {1..$t} )
  do
      current_packet_length=0; subs=FFFF
      [[ $DEBUG == 1 ]] && bclog "iteration $i dds_packet_start = $dds_packet_start infile = $infile"
      [[ $DEBUG == 1 ]] && bclog "#######################"
      [[ $DEBUG == 1 ]] && bclog "### START PACKET $i  ###"
      [[ $DEBUG == 1 ]] && bclog "#######################"
      current_packet_length=$(get_dds_hd_pktlen "$infile" $dds_packet_start)
      [[ $DEBUG == 1 ]] && bclog "ccsds current_packet_length (hex) = $current_packet_length"
      #current_packet_length=$(bbe -s -b "8:4" "$1" | xxd -u | awk  'BEGIN{FS=":"} {print $2}' | awk  'BEGIN{FS="."} {print $1}' | sed -e "s/ //g")
      #dcurrent_packet_length contains the packet length of the ccsds payload as a decimal value, it may include a variable length part
      dcurrent_packet_length=$( hextodec $current_packet_length )
      #hextodec $current_packet_length
      [[ $DEBUG == 1 ]] && bclog "ccsds current packet length (dec) = $dcurrent_packet_length"
      #str1=$(echo bbe -s -b $ccsds_packet_start:$dcurrent_packet_length $infile ); [[ $DEBUG == 1 ]] && bclog "$str1"
      ## following instruction dumps dds header on a variable containing an hex string
      
      #ddshdxs=$(bbe -s -b $dds_packet_start:$(get_dds_hd_length) $infile | bin/ccsdstohex -)
      ## following instruction dumps ccsds packet on a variable containing an hex string
      ccsdsxs=$(bbe -s -b $ccsds_packet_start:$dcurrent_packet_length $infile | bin/ccsdstohex -)
      # extract ssc
      DEBUG=1
      [[ $DEBUG == 1 ]] && debug "ccsds pkt hexstr = $ccsdsxs"
      #set APID
      subs=${ccsdsxs:1:3}; [[ $DEBUG == 1 ]] && debug "setAPID_hex $subs";
      apidx=$(echo $( dectohex $(( $(hextodec $subs) & $(hextodec "7FF") )) ) )
      [[ $DEBUG == 1 ]] && debug "APID = $apidx"
      [[ $DEBUG == 1 ]] && debug "bAPID = $( dectobin $(( $(hextodec $subs) & $(hextodec "7FF") )) )"
      ###
      set_s2k_hd_apid_hex $apidx
      ###
      
      subs=${ccsdsxs:4:4}; [[ $DEBUG == 1 ]] && debug "setSSC_hex $subs";
      #$(echo $( dectohex $(( $(hextodec $subs) & $(hextodec "3FFF") ) ) ))
      sscx=$(echo $( dectohex $(( $(hextodec $subs) & $(hextodec "3FFF") )) ) )
      #sscx=F00F
      
      [[ $DEBUG == 1 ]] && debug "bSSC = $( dectobin $(( $(hextodec $subs) & $(hextodec "3FFF") )) )"
      #setSSC_hex $subs
      set_s2k_hd_ssc_hex $sscx 
      DEBUG=0

      #DEBUG=0
      indent 6 ;openTagAttributes "PktRawResponseElement" "packetID" "$pktcount"; set_caller_local
      indent 8 ;openTagn "Packet"
      s2kthdxs=$(get_s2k_tothd_hex)
      echo -n "$s2kthdxs"; echo -n "$ccsdsxs"
      closeTag "Packet"
      indent 6 ;closeTag  "PktRawResponseElement"

      # increment for the iteration on next packet in the file
      dds_packet_start=$(($dcurrent_packet_length + $ccsds_packet_start)); #update the offset
      #      dds_packet_start=$(( $dds_packet_end +  ))
      DEBUG=1
      [[ $DEBUG == 1 ]] && bclog "dds_packet_start = $dds_packet_start"
      ccsds_packet_start=$(($dds_packet_start+18))
      ((pktcount++)) # increment pkt counter
      [[ $DEBUG == 1 ]] && bclog "#######################"
      [[ $DEBUG == 1 ]] && bclog "### END PACKET $i    ###"
      [[ $DEBUG == 1 ]] && bclog "#######################"
  done
      indent 4 ;closeTag  "PktRawResponse"
      indent 2 ;closeTag  "Response"
      closeTag  "ResponsePart"
      [[ $DEBUG == 1 ]] && bclog "just after the packets loop"
      [[ $DEBUG == 1 ]] && bclog "processed $(( $pktcount - 1 )) packets"
      [[ $DEBUG == 1 ]] && bclog "END OF PROGRAM"
fi
# example of run
# bin/dds2xml.sh  indata/dds/2019-07-22_tm.dds 5  2> log/2019-07-22_tm_err.log; cat log/2019-07-22_tm_err.log  | grep "###"
####
#-----------------------------------------
# s0 s1 s2 s3  s4 s5 s6 s7   s8 s9 s10 s11 
#  0  1  1  1   1  1  1  1    1  1  1   1
#-----------------------------------------
#    7              F              F 
