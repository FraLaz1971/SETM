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
