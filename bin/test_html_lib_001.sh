#!/bin/bash
. lib/utils_lib
. lib/html_lib
# test_html_lib_001.sh prints an html page with a plot product table with a given number of rows, each row with 2 columns/cells
DEBUG=0 # when in DEBUG=1 prints more log messages
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <nrows> "
  exit $E_BADARGS
else
    DEBUG=1 # when in DEBUG=1 prints more log messages
    #    [[ $DEBUG = 1 ]] && debug "### START OF PROGRAM ###"
    [[ $DEBUG = 1 ]] && bclog "### START OF PROGRAM ###"
    [[ $DEBUG = 1 ]] && debug "hello bepi!! creating html5 output on file $1"
    putHTMLdeclaration
    html_comment "declaring the document type"
    openTag "html"
    html_comment "opening html tag"
    openTag "head"
    html_comment "opening head tag"
    openTagAttributes "meta" "charset" "UTF-8"
    setTitle "this page shows BC ESA/JAXA mission data products"
    closeTag "head"
    openTag "body"
    declare -i lr
    lr="$1"; cc=1; rc=1
    html_comment "now creating a table containing example plots"
    openTagAttributes "table" "style" "width:100%" "border" "1" ;# "heigth" "10cm"; 
    html_comment "opening table tag"
    openTagn "caption"; echo -n "table of BC products";closeTag "caption"
    for rown in $(eval echo {1..$lr})
    do
      openTableRaw
        openTableCell
        altt="example_plot_n_$rown"_"$cc"; html_image "outdata/png/example_plot1.png" "$altt"
        echo -n "<h2>$rown $cc</h2>"; ((cc++))
        closeTableCell
        openTableCell
        altt="example_plot_n_$rown"_"$cc"; html_image "outdata/png/example_plot1.png" "$altt"
        echo -n "<h2>$rown $cc</h2>"; ((cc++))
        closeTableCell
      closeTableRaw
        cc=1
    done
    closeTag "table"
    html_comment "closing table tag"

    # put here html page content
    
    closeTag "body"
    html_comment "closing body tag"

    closeTag "html"
    html_comment "closing html page"
    
    [[ $DEBUG = 1 ]] && bclog "### END OF PROGRAM ###"
    DEBUG=0 # when in DEBUG=1 prints more log messages
fi

#example usage: bin/test_html_lib_001.sh 4 > ciao2.htm; konqueror ciao2.htm &
#example usage: bin/test_html_lib_001.sh 4 | konqueror "data:text/html;base64,$(base64 -w 0 <&0)"