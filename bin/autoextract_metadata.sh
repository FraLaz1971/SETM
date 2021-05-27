#!/bin/bash
# /*
#  * @file autoextract_metadata.sh
#  * @brief error values for a simple bash library, suitable for science research
#  * containing sw tools to be used in the P/L experiments
#  * onboard the ESA/JAXA BepiColombo space mission 
#  * http://sci.esa.int/bepicolombo
#  * @copyright (C) 2019 GPL 2 free software license 
#  * @author Francesco Lazzarotto (INAF - OAPD) Francesco.lazzarotto@inaf.it
#  * 
#  * This program is free software; you can redistribute it and/or modify
#  * it under the terms of the GNU General Public License as published by
#  * the Free Software Foundation; either version 2 of the License, or
#  * (at your option) any later version. (GPL-2.0-or-later)
#  * 
#  * This program is distributed in the hope that it will be useful,
#  * but WITHOUT ANY WARRANTY; without even the implied warranty of
#  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  * GNU General Public License for more details.
#  * 
#  * You should have received a copy of the GNU General Public License along
#  * with this program; if not, write to the Free Software Foundation, Inc.,
#  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#  * 
#  * library definition to be sourced from a main program/script
#  */

. lib/csv_lib
  declare -i cmw #first record flag=1
 unset LC_NAME;unset LC_UNIT;declare -a LC_TYPE;declare -a LC_SIZE
 declare -a LC_NAME;declare -a LC_UNIT;declare -a LC_TYPE;declare -a LC_SIZE
DEBUG=0 # when in debug prints more log files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <infile.csv> "
  exit $EX_BADARGS
else
  debug "extracts metadata from csv tables and saves it"
  infile="$1"
  cmw=0; #flag cmw=1 on first data row found; cmw=2 on second data row found
  #BNR = number of csv records/lines in bash,  BNDR = n. of data records
  BNR=0; BNDR=0; 
  {
      while read line 
      do           # for all lines of input file ... do something on the line elements
        #echo "processing line BNR = $BNR content $line, first char ${line:0:1} BNDR = $BNDR"
        #debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR"
        #debug "line = $line"
        if [[ ${line:0:1} == "#" ]] 
        then
          REMARKS[$BNR]=$line
          debug "BNR = $BNR, ch1=${line:0:1} BNDR = $BNDR ->comments";
          maxcom=$(($maxcom+1))
        else
          #ch1 != # --> found first data row: extract metadata
          [[ $DEBUG = 1 ]] && debug "BNR = $BNR, ch1=${line:0:1} BNDR = $BNDR->rows"
          cmw=$(($cmw+1))
          #debug "N_COLS=$(echo "$line" |  awk -f bin/get_ncols.awk)"
          # set the number of fields contained in a record  taking the n. of records of the first data row
          if [[ "$BNDR" -eq 1 ]]; 
          then 
            NF=$(echo "$line" |  awk -f bin/get_ncols.awk); 
            set_table_size "$NF"; 
          fi
          # if first data record -->set columns metadata
          [[ $DEBUG = 1 ]] && debug "checking cmw value = $cmw"
          if [[ "$cmw" -eq 1 ]]
          then
            [[ $DEBUG = 1 ]] && debug "first data row found: setting metadata, cmw = $cmw"
            
            [[ $DEBUG = 1 ]] && debug "REMARKS[$(($BNR-4))] = ${REMARKS[$(($BNR-4))]}"
            citer=0
            li=$(echo "${REMARKS[$(($BNR-4))]}" | sed -e 's/#//' -e 's/,/ /g' |  awk 'BEGIN{FS=","} {print $1,$2,$3}')
            for col_val in $li
            do
              #set columns name
              DEBUG=1
              [[ $DEBUG = 1 ]] && debug "exec. LC_NAME[$citer]=$col_val"
              LC_NAME[$citer]=$col_val
              [[ $DEBUG = 1 ]] && debug "checking LC_NAME[$citer] set to ${LC_NAME[$citer]}"
              citer=$(($citer+1))
              DEBUG=0
            done 
            [[ $DEBUG = 1 ]] && debug "REMARKS[$(($BNR-3))] = ${REMARKS[$(($BNR-3))]}"
            citer=0
            li=$(echo "${REMARKS[$(($BNR-3))]}" | sed -e 's/#//' -e 's/,/ /g' |  awk 'BEGIN{FS=","} {print $1,$2,$3}')
            for col_val in $li
            do
              #set columns physical units
              [[ $DEBUG = 1 ]] && debug "exec. LC_UNIT[$citer]=$col_val;citer=$(($citer+1))"
              LC_UNIT[$citer]=$col_val;citer=$(($citer+1))
            done
            [[ $DEBUG = 1 ]] && debug "REMARKS[$(($BNR-2))] = ${REMARKS[$(($BNR-2))]}"
            citer=0
            li=$(echo "${REMARKS[$(($BNR-2))]}" | sed -e 's/#//' -e 's/,/ /g' |  awk 'BEGIN{FS=","} {print $1,$2,$3}')
            for col_val in $li
            do 
              [[ $DEBUG = 1 ]] && debug "exec. LC_TYPE[$citer]=$col_val;citer=$(($citer+1))"
              #set columns data types
              LC_TYPE[$citer]=$col_val;citer=$(($citer+1))
            done
            [[ $DEBUG = 1 ]] && debug "REMARKS[$(($BNR-1))] = ${REMARKS[$(($BNR-1))]}"
            citer=0
            li=$(echo "${REMARKS[$(($BNR-1))]}" | sed -e 's/#//' -e 's/,/ /g' |  awk 'BEGIN{FS=","} {print $1,$2,$3}')
            for col_val in $li
            do
              [[ $DEBUG = 1 ]] && debug "exec. LC_SIZE[$citer]=$col_val;citer=$(($citer+1))"
              #set columns data size (in BYTES)
              LC_SIZE[$citer]=$col_val;citer=$(($citer+1))
            done
          else
            [[ $DEBUG = 1 ]] && debug "cmw = $cmw, doing nothing"
            [[ $DEBUG = 1 ]] && debug "total row n $maxrec"
            [[ $DEBUG = 1 ]] && debug "data row n $maxrec"
          fi
          RECORDS[$BNDR]=$line #insert the line in the records array
          [[ $DEBUG = 1 ]] && debug "line: $line"
          [[ $DEBUG = 1 ]] && echo "$line" |  awk -f bin/csvrow2xmlrec.awk # converts csv row to xml record
          BNDR=$(( $BNDR+1 ))
          maxrec=$(($maxrec+1))
        fi
        BNR=$(( $BNR+1 ))    
       done # close loop on input csv file lines/records
    }<"$infile"

  debug "executing set_table_size $NF BNDR=$BNDR"
  set_table_size "$NF"; 
  debug "executing set_names $(echo ${LC_NAME[@]}) BNDR=$BNDR"
  set_names ${LC_NAME[@]} 
  debug "executing set_units $(echo ${LC_UNIT[@]}) BNDR=$BNDR"
  set_units ${LC_UNIT[@]} 
  set_types ${LC_TYPE[@]} 
  set_sizes ${LC_SIZE[@]} 

  #set_outdir $(dirname "$1")
  odv="data/$(get_timestamp)"
  mkdir $odv 
  set_outdir "$odv"
  set_filename $(basename "$1")
  debug "data filename; $(get_out_data_fname)"
  debug "conf filename; $(get_out_conf_fname)"
  print_comments $(get_out_data_fname)
  print_metadata "$NF" $(get_out_conf_fname)
  print_data $(get_out_data_fname)
  declare -p LC_NAME; declare -p LC_UNIT;
  #csv_report
fi
#example usage: bin/autoextract_metadata.sh indata/csv/test_utils_input_01.csv
