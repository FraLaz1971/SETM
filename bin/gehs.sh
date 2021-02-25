#!/bin/bash
# generates multilines random elena histograms
declare -r DEBUG=true
declare -a hv # elena histogram values
. lib/graphics_lib
prog="gesh"
if [[ $# -eq 1 ]]; then 
  debug "1 param: ok $0 run!"
else
    echo "usage $0 <n.histo>"
    exit 1
fi

setdebuglevel "INFO"
nfr=$(mktemp --suffix=_on_rows.dat)
debug "creating gnuplot temp script in $nf"
genehist $1 > $nfr
if ((! $?)); then debug "elena histograms generated (histos on rows) on file $nfr"; fi
nfc=$(mktemp --suffix="_on_cols.dat")
debug "creating reversed histo data file (histogram on columns) on file $nfc"
./reverse_histo.awk $nfr > $nfc
debug "created reversed histo data file (histogram on columns) in $nfc"
debug "removing histogram on rows data file in $nfr"
if test -f $nfr; then rm $nfr; fi
nf=$(mktemp --suffix=".gp")
create_gp_ts $nf $nfc
debug "created gnuplot temp script in $nf"
debug "running gnulplot"
gnuplot --persist "$nf"
debug "removing gnuplot temp script in $nf"
if test -f $nf; then rm $nf; fi
debug "gnuplot temp script $nf removed"
echo "removing histogram on cols data file $nfc"
echo "do you want to delete histogram (on cols) data file ? (y/n) [enter]"
remove_tempfile $nfc
