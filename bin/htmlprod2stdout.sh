#!/bin/bash
. lib/utils_lib
. lib/html_lib


DEBUG=0 # when in DEBUG=1 prints more log messages
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <outfile.htm> "
  exit $E_BADARGS
else
    DEBUG=1 # when in DEBUG=1 prints more log messages
    #    [[ $DEBUG = 1 ]] && debug "### START OF PROGRAM ###"
    [[ $DEBUG = 1 ]] && bclog "### START OF PROGRAM ###"
    [[ $DEBUG = 1 ]] && debug "hello bepi!! creating html5 output on file $1"
    openTag "html"
    openTag "head"
    openTagAttributes "meta" "charset" "UTF-8"
    setTitle "this page shows BC ESA/JAXA mission data products"
    closeTag "head"
    openTag "body"
    if test -f "$1"; then echo "<h1>file $1 is present</h1>"; ls -alhrt "$1"; else echo "<h1>file $1 is not present</h1>"; fi
    #    [[ $DEBUG = 1 ]] && debug "### END OF PROGRAM ###"
    

    # put here html page content
    

    closeTag "body"

    closeTag "html"

    
    [[ $DEBUG = 1 ]] && bclog "### END OF PROGRAM ###"
    DEBUG=0 # when in DEBUG=1 prints more log messages
fi

#example usage: bin/test_html_lib_001.sh ciao.htm | konqueror "data:text/html;base64,$(base64 -w 0 <&0)"