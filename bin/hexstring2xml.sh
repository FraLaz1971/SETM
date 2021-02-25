#!/bin/bash
#this script converts hexstrings TM packet file to xml response format TM file
. lib/xml_lib
. lib/utils_lib

DEBUG=0
openResponse(){
  openTag "ResponsePart"
  openTag "Response"
  openTag "PktRawResponse"
}

closeResponse(){
  closeTag "PktRawResponse"
  closeTag "Response"
  closeTag "ResponsePart"
}

debug "expecting input from stdin ..."
putDeclaration
openResponse
  ### process packets
  lc=1 #linecounter initialisation
  {
    while read line 
      do           # for all lines of input file ... do something!
        [[ $DEBUG = 1 ]] && debug "read hexstring $line"
        openTagAttributes "PktRawResponseElement" "packetID" $lc
        openTag  "Packet";echo $line;closeTag "Packet"
        closeTag "PktRawResponseElement"
        ((lc++))
      done
  }</dev/stdin
  ### end loop on hexstring packets 
closeResponse