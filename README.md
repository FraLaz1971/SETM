@brief process BepiColombo TM data
-------------------------------------------
bash libraries and scripts and other utility files 
to process TM data starting from BepiColombo space
mission examples.
The TM data follow the CCSDS international standard and
ESA / ECSS PUS european standard.
binary data are handled and converted to HEX
ascii dump and then in ascii / fits / pds4
for science interpretation and study.
Moreover the library allow engineering
check on space instruments data
-------------------------------------------
last update date: 2021-04-07
-------------------------------------------
-------------------------------------------
update date: 2021-02-25
-------------------------------------------
@author: francesco lazzarotto
@mailto: francesco.lazzarotto@inaf.it
#date: 2019-10-02 
the following files are listed and described
----------------------------------------------------------------------------------------------
autoextract_metadata.sh ----> extract table metadata from a csv table file 
and saves on a conf file
----------------------------------------------------------------------------------------------
bin/test_tm_1pkt.sh  ----> create an output ccsds tm file
-------------------------------------------

the following example shows how to create an output ccsds tm file
the program can be used from the terminal command line

-------------------------------------------
# example usage #
-------------------------------------------
bin/test_tm_1pkt.sh  > out2.ccsds; xxd -u out2.ccsds | awk 'BEGIN{FS=":"}{print $2}' | awk '{print $1 $2 $3 $4 $5 $6 $7 $8}' | awk 'BEGIN{FS="."}{print $1}'
-----------------------------------------------
#remember:
-------------------------------------------
xxd -r ---> reverses ascii hexdumps to binary files
-------------------------------------------
xxd -i ---> create a c language array containing the content of a binary file
-------------------------------------------
od ---> create octal/decimal/hex dump of files
-------------------------------------------

------------------------------------------
#bbe based scripts
-------------------------------------------
bin/script1.bbe --->  convert dds files to ccsds files
-------------------------------------------
# contained files
ar1.dat
chtimetolog.awk
ciccio
ciccio.log
colon2tab.vbs
create_and_plotimage.sh ---> program able to create and plot an rgb ascii image format x,y,val(x,y) 
createimage.sh		---> program able to create an image
ef			---> library containing utilities to process science data
err.log
errs
funtest
gehs.sh 		---> generate elena histograms file, subsequent plots of ELENA histograms 
histo2.dat
histo.dat
histos.dat	
histos_r.dat
image2X3.dat		---> example of an ascii file containing a 2X3 pixel ascii image
image32X10.dat
iso8601_hhmm.gp
iso8601_hhmm.tsv
mktemp
mystt.dat
mytt.dat
out1
plot2x3image.gp		---> gnuplot script file that plots a 2x3 pixel image, needs image2X3.dat
plotimage.sh		---> program that plot a given image (file)
README
reverse_histo.awk	---> awk program that reverse ELENA hirogram file (in rows) to columns
rotate90.awk
test1.txt
test3.gp
timetemp.gp
timetest2.gp
timetest3.gp
---------------------------------------------------------------------------------------------------
04000000000B00000000000000000000
04000000000B00000000000000000000
-----
000011100100110011000000000101000000000000001010
-----
a=$(bin/test_tm_1pkt_brief.sh); xs=$(bintohex $a); ad=$(( $(echo $a | wc -c ) -1 ));eval leftpadstring $xs $(( $ad/4 )) '0'
0E4CC014000A
----
fn=""out10pkts_20190820T231710.ccsds;xxd -u  $fn | awk 'BEGIN{FS=":"}{print $2}' | awk '{print $1 $2 $3 $4 $5 $6 $7 $8}' | awk 'BEGIN{FS="."}{print $1}'
--------------------------------------------------------------------------
ccsdstohex
ccsdstohex16Br
create_and_plotimage.sh
createimage.sh
decode_elena_event.sh
extract_timemark_event.sh
funtest
gehs.sh
getapid.sh
keypress.sh
plotimage.sh
--------------------------------------------------------------------------
2019-09-13
--------------------------------------------------------------------------
script1.bbe
script1.bbols
script1_err.bbe
script2_bbe.sh
script3_bbe.sh ---> read dds files, for each packet decode dds/ccsds/pus header fields and dump Data Fields to ascii hex
script4.sh
sendrawtoegse
sendrawtoegse
sendrawtoegse_dummy
sendrawtoegse_ESOC
sendrawtoegse_ESOC_IAPS
sendrawtoegse_IAPS
test1
test_tm_1pkt_brief.sh
test_tm_1pkt.sh
test_tm_1pkt_superbrief.sh
test_tm_1.sh
test_tm_2.sh
test_tm_dfh_1.sh
--------------------------------------------------------------------------
23 September 2019
--------------------------------------------------------------------------
bin/script3_bbe.sh
this script handle all packets in a dds binary tm file and does something
--------------------------------------------------------------------------
## GDDS binary header fields (bit arrays)

declare -a dds_hd_gentime   # Generation Time (8 octets)
declare -a dds_hd_pktlen    # Packet length (4 octets)
declare -a dds_hd_gndstid   # Ground station ID (2 octets)
declare -a dds_hd_vcid      # Virtual Channel ID (2 octets)
declare -a dds_hd_slesrvid  # SLE Service ID (1 octet)
declare -a dds_hd_tmqf      # Time Quality Flag (1 octet)

--------------------------------------------------------------------------
csv2xml.sh ---> converts csv (tables) files in the corresponding xml table
--------------------------------------------------------------------------
#example usage: bin/csv2xml.sh indata/csv/test_utils_input_01.csv
--------------------------------------------------------------------------
bin/csvdatanames2pds4label.sh ---> create the pds4 label starting from csvdatanames2pds4label
--------------------------------------------------------------------------
# get_dds_hd_pktlen gives the length in bytes of the whole ccsds packet
# dds2hexstrings.sh ---> takes as input dds binary tm file and gives ccsds hexstrings as ouptut (ascii hex strings on the stdout. Each line is a record corresponding to a single ccsds packet)
--------------------------------------------------------------------------

############################
# 25/10/2019              ##
############################
bin/autoextract_metadata.sh
bin/ccsdstohex
bin/ccsdstohex16Br
bin/create_and_plotimage.sh
bin/createimage.sh
bin/csv2conf.awk
bin/csv2conf.sh
bin/csv2xml.awk
bin/csv2xml_backup.sh
bin/csv2xml.sh
bin/csvdatanames2pds4label.sh
bin/csvrow2xmlrec.awk
bin/cutddspackets.sh
bin/dds2ccsdshex.sh
bin/dds2ccsds.sh
bin/dds2ddshex.sh
bin/dds2hexstrings.sh
bin/dds2hexstr.sh
bin/dds2s2khex.sh
bin/dds2ssc.sh
bin/debug.sh
bin/decode_elena_event.sh
bin/example_old.sh
bin/extract_timemark_event.sh
bin/funtest
bin/gehs.sh
bin/getapid.sh
bin/get_metadata.awk
bin/get_ncols.awk
bin/get_part1_metadata.awk
bin/hexstring2xml.sh
bin/HKSamples_csv2xml.sh
bin/HKSamples_csvrow2xmlrec.awk
bin/htmlprod2stdout.sh
bin/keypress.sh
bin/log.sh
bin/plotimage.sh
bin/script1.bbe
bin/script1_err.bbe
bin/script2_bbe.sh
bin/script3_bbe.sh
bin/script4.sh
bin/sendrawtoegse
bin/sendrawtoegse~
bin/sendrawtoegse_dummy
bin/sendrawtoegse_ESOC
bin/sendrawtoegse_ESOC_IAPS
bin/sendrawtoegse_IAPS
bin/srn_pipe_example.sh
bin/test1
bin/test_csv_lib_01.sh
bin/test_csv_lib_02.sh
bin/test_dataset_lib_01.sh
bin/test_file_lib_01.sh
bin/test_html_lib_001.sh
bin/test_matrix_dataset_lib_02.sh
bin/test_tm_1.sh
bin/test_tm_2.sh
bin/test_tm_dfh_1.sh
bin/test_utils_lib.sh
bin/testxmllib.sh

bin/CVS:
Entries
Repository
Root
project /home/francesco/projects/hypsos010 created by  on Tue Jul 14 06:59:14 CEST 2020
