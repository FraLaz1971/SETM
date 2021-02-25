#!/bin/bash
# /*
#  * @file csv2xml.sh
#  * @brief executable bash script that converts csv files to xml simple 
#  * part of the bash library, suitable for science research
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

. lib/errvals
. lib/utils_lib
. lib/xml_lib

# records related variables
N_REMARKS=0 #n. of comment lines in the input file (inizialisation)
N_RECORDS=0 #n. of data lines/records in the file (inizialisation)
REMARKS[0]=""; remcnt=0; # index for iterating on the comments header
RECORDS[0]=""; reccnt=0; # index for iterating on the data lines

#fields related variables
N_FIELDS=0 #n. of data fields in one record for this file (inizialisation)


DEBUG=0 # when in debug prints more log files
if [[ $# != 1 ]]
then
  debug "usage: $(basename $0) <infile.csv> "
  exit $E_BADARGS
else
  putDeclaration
  xml_comment "csv2xml.sh converts csv tables into xml tables"
  putModel "http://pds.nasa.gov/pds4/pds/v1/PDS4_PDS_1B00.sch" "http://purl.oclc.org/dsdl/schematron"
  putModel "http://pds.nasa.gov/pds4/geom/v1/PDS4_GEOM_1A10.sch" "http://purl.oclc.org/dsdl/schematron"
  putModel "http://psa.esa.int/psa/v1/PDS4_PSA_1100.sch" "http://purl.oclc.org/dsdl/schematron"
  putModel "http://psa.esa.int/psa/bc/v1/PDS4_PSA_BC_1003.sch" "http://purl.oclc.org/dsdl/schematron"

  openTagAttributes Product_Observational xmlns "http://pds.nasa.gov/pds4/pds/v1" \
    xmlns:geom "http://pds.nasa.gov/pds4/geom/v1" \
    xmlns:psa "http://psa.esa.int/psa/v1" \
    xmlns:bc "http://psa.esa.int/psa/bc/v1" \
    xmlns:xsi "http://www.w3.org/2001/XMLSchema-instance" \
    xsi:schemaLocation 'http://pds.nasa.gov/pds4/pds/v1 http://pds.nasa.gov/pds4/pds/v1/PDS4_PDS_1B00.xsd http://pds.nasa.gov/pds4/geom/v1 http://pds.nasa.gov/pds4/geom/v1/PDS4_GEOM_1A10.xsd http://psa.esa.int/psa/v1 http://psa.esa.int/psa/v1/PDS4_PSA_1100.xsd http://psa.esa.int/psa/bc/v1 http://psa.esa.int/psa/bc/v1/PDS4_PSA_BC_1003.xsd'
    # write identification area metadata
      openTag   "Identification_Area"
        openTag   "logical_identifier"
          echo "urn:esa:psa:bc_mpo_serena:data_raw:srn_raw_hk_elena_20181212T084923"
        closeTag   "logical_identifier"
	openTag   "version_id"
          echo "0.1"
	closeTag   "version_id"
	openTag   "title"
          echo "BEPICOLOMBO MPO SERENA/ELENA NEAR EARTH COMMISSIONING RAW SENSOR HOUSEKEEPING DATA PRODUCT"
        closeTag   "title"
        openTag   "information_model_version"
          echo "1.11.0.0"
        closeTag   "information_model_version"
	openTag   "product_class"
          echo "Product_Observational"
        closeTag   "product_class"
        openTag "Modification_History"
            openTag "Modification_Detail"
                openTag "modification_date"
                  echo "2019-07-29"
                closeTag "modification_date"
                openTag "version_id"
                  echo "0.1"
                  closeTag "version_id"
                  openTag "description"
                  echo "This is the first version of this product"
                  closeTag "description"
            closeTag "Modification_Detail"
        closeTag "Modification_History"
      closeTag "Identification_Area"
    # write observation area meatadata
      openTag "Observation_Area"
    # time
        openTag "Time_Coordinates"
                      openTag "start_date_time"
                        echo "2018-12-12T08:49:23.204" #<--- REMEMBER TO SET measurement tstart
                      closeTag "start_date_time"
                      openTag "stop_date_time"
                        echo "2018-12-15T17:54:16.804" #<--- REMEMBER TO SET measurement tstop
                      closeTag "stop_date_time"
        closeTag "Time_Coordinates"
        openTag "Primary_Result_Summary"
                          openTag "purpose"
                            echo "Engineering"
                          closeTag "purpose"
                          openTag "processing_level"
                            echo "Raw"
                          closeTag "processing_level"
                          openTag "description"
                            echo "This file contains raw HK from ELENA"
                          closeTag "description"
                          openTag "Science_Facets"
                                  openTag "domain"
                                    echo "EARTH"
                                  closeTag "domain"
                                  openTag "discipline_name"
                                    echo "Particles"
                                  closeTag "discipline_name"
                          closeTag "Science_Facets"
         closeTag "Primary_Result_Summary"
      #Investigation Area
         openTag "Investigation_Area"
           openTag "name"
            echo "BEPICOLOMBO"
           closeTag "name"
           openTag "type"
            echo "Mission"
           closeTag "type"
           openTag "Internal_Reference"
             openTag "lid_reference"
                echo "urn:esa:psa:context:investigation:mission.bc"
             closeTag "lid_reference"
             openTag "reference_type"
                echo "data_to_investigation"
             closeTag "reference_type"
           closeTag "Internal_Reference"
        closeTag "Investigation_Area"
      #Observing System
      openTag "Observing_System" 
			openTag "Observing_System_Component" #S/C description part begin
                          openTag  "name"
                            echo "Mercury Planetary Orbiter"
                          closeTag "name"
                          openTag "type"
                            echo "Spacecraft"
                          closeTag "type"
					openTag "Internal_Reference"
					    openTag "lid_reference"
                                              echo "urn:esa:psa:context:instrument_host:spacecraft.mpo"
					    closeTag "lid_reference"
					    openTag "reference_type"
                                              echo "is_instrument_host"
					    closeTag "reference_type"
					closeTag "Internal_Reference"
			closeTag "Observing_System_Component" #S/C description part end
			  	
			openTag "Observing_System_Component" #P/L Instrument description part begin   
                          openTag   "name"
                                  echo "SERENA"
                          closeTag  "name"
                          openTag   "type"
                                  echo "Instrument"
                          closeTag "type"
                          openTag   "description"
                                          echo "SERENA"
                          closeTag "description"
                          openTag   "Internal_Reference"
                            openTag   "lid_reference"
                              echo "urn:esa:psa:context:instrument:serena.mpo"
                            closeTag   "lid_reference"
                            openTag   "reference_type"
                              echo "is_instrument"
                            closeTag "reference_type"
                          closeTag "Internal_Reference"
                        closeTag "Observing_System_Component" #P/L Instrument description part end
                      closeTag "Observing_System"
      #Target identification
      	    openTag   "Target_Identification"
	      openTag   "name"
                echo "MERCURY"
              closeTag "name"
	      openTag   "type"
                echo "Planet"
              closeTag  "type"
	      openTag   "Internal_Reference"
	          openTag   "lid_reference"
                    echo "urn:nasa:pds:context:target:planet.mercury"
                  closeTag  "lid_reference"
	          openTag   "reference_type"
                    echo "data_to_target"
                  closeTag  "reference_type"
	      closeTag "Internal_Reference"
	    closeTag "Target_Identification"

      #Mission Area
      
	    openTag  "Mission_Area"
	        openTag  "psa:Mission_Information"
	            openTag  "psa:spacecraft_clock_start_count"
                      echo "1/0609324563.00000"
                    closeTag "psa:spacecraft_clock_start_count"
	            openTag  "psa:spacecraft_clock_stop_count"
                      echo "1/0609616456.39322"
	            closeTag "psa:spacecraft_clock_stop_count"
	            openTag  "psa:mission_phase_name"
                      echo "NEAR EARTH COMMISSIONING"
                    closeTag "psa:mission_phase_name"
	            openTag  "psa:mission_phase_identifier"
                      echo "necp"
                    closeTag "psa:mission_phase_identifier"
	        closeTag "psa:Mission_Information"
	        openTag  "psa:Sub-Instrument"
	            openTag  "psa:identifier"
                      echo "ELENA"
	            closeTag "psa:identifier"
	            openTag   "psa:name"
                      echo "ELENA"
                    closeTag  "psa:name"
	            openTag  "psa:type"
                      echo "Particle analyser"
                    closeTag "psa:type"
	            openTag  "psa:type"
                      echo "Imager"
	            closeTag "psa:type"
	        closeTag "psa:Sub-Instrument"
	        openTag  "psa:Processing_Context"
	            openTag  "psa:processing_software_title"
                      echo "serena_tm2raw"
                    closeTag "psa:processing_software_title"
	            openTag  "psa:processing_software_version"
                      echo "1.0"
                    closeTag "psa:processing_software_version"
	            openTag  "psa:Processing_Inputs"
	                openTag  "psa:Processing_Input_Identification"
	                    openTag  "psa:type"
                              echo "telemetry"
	                    closeTag "psa:type"
	                    openTag  "psa:file_name"
                              echo "primo_necp.RawSourceBinary"
                            closeTag "psa:file_name"
	                closeTag "psa:Processing_Input_Identification"
	                openTag  "psa:Processing_Input_Identification"
	                    openTag  "psa:type"
                              echo "SPICE kernel"
                            closeTag "psa:type"
	                    openTag  "psa:file_name"
                              echo "serena_mk.tm"
	                    closeTag "psa:file_name"
	                closeTag "psa:Processing_Input_Identification"
	            closeTag "psa:Processing_Inputs"
	        closeTag "psa:Processing_Context"
	    closeTag "Mission_Area" 
      closeTag  "Observation_Area"
  
      openTag  "File_Area_Observational"
        openTag  "File"
        closeTag "File"
        openTag  "Table_Delimited"
          openTag  "Record_Delimited"
            infile="$1"
            #BNR = number of csv records/lines in bash,  BNDR = n. of data records
            BNR=0; BNDR=0
            {
                while read line 
                do           # for all lines of input file ... do something on the line elements
                  #echo "processing line BNR = $BNR content $line, first char ${line:0:1} BNDR = $BNDR"
                  #debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR"
                  #debug "line = $line"
                  if [[ ${line:0:1} == "#" ]] 
                  then
                    REMARKS[$BNR]=$line
                    debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR->comment";
                  else
                    RECORDS[$BNDR]=$line
                    # extract metadata
                    # set the number of fields in one record
                    debug "processing line BNR = $BNR, first char ${line:0:1} BNDR = $BNDR->normal line"
          #          echo "$line" |  awk -f bin/csvrow2xmlrec.awk # converts csv row to xml record
                    nl=""
                    nl=$(echo "$line" | awk 'BEGIN{ OFS="";FS=","; i=1} { while (i<=NF){print $i; i++} }')
                    fc=1
                    for l in $nl 
                    do
                      openTag  "Field_Delimited"
                      openTag  "name"
                      #debug "l = $l"
                      echo "$l"
                      closeTag "name"
                      openTag  "field_number"
                      echo $fc
                      closeTag "field_number"
                      openTag  "data_type"
                      echo "ASCII_NonNegative_Integer"
                      closeTag "data_type"
          # 					<name>SCET</name>
          # 					<field_number>3</field_number>
          # 					<data_type>ASCII_NonNegative_Integer</data_type>
                      closeTag "Field_Delimited"
                      ((fc++))
                    done
                    BNDR=$(( $BNDR+1 ))
                  fi
                  BNR=$(( $BNR+1 ))    
                done # close loop on input csv file lines/records
              }<"$infile"
          closeTag "Record_Delimited"
        closeTag "Table_Delimited"
      closeTag "File_Area_Observational"
  closeTag "Product_Observational"
fi #check on correct number of input arguments

report(){
  debug "processed file: $infile"
  debug "tot n. of lines: $(($BNR-1))"
  debug "n. of data records: $(($BNDR-1))"
}

#print all read lines in the comments
print_remarks(){
  i=0
  MAX=$(( ${#REMARKS[*]} - 1 ))
  for i in  $(  eval echo  {0..$MAX})
  do
    echo "REMARKS[$i] = ${REMARKS[$i]}"
  done
}
#print all data records/row of the read csv file
print_data(){
  i=0
  MAX=$(( ${#RECORDS[*]} - 2 ))
  for i in  $(  eval echo  {0..$MAX})
  do
    echo "RECORDS[$i] = ${RECORDS[$i]}"mountcybo  
  done
}

print_metadata(){
  :
}

# report
# print_remarks
# print_data
# print_metadata
# 
#example usage: bin/csvdatanames2pds4label.sh indata/csv/serena_raw_elena_hk_datanames.csv > indata/xml/serena_raw_elena_hk_records.xml