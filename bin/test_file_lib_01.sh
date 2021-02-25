#!/bin/bash
# /*
#  * @test_file_lib_01.sh
#  * @brief simple bash script testing the file_lib library
#  * containing sw tools to be used in the P/L experiments
#  * onboard the ESA/JAXA BepiColombo space mission 
#  * http://sci.esa.int/bepicolombo
#  * @copyright (C) 2019 GPL 2 free software license 
#  * @author Francesco LaZZarotto (INAF - OAPD) Francesco.laZZarotto@inaf.it

. lib/file_lib
. lib/utils_lib
. lib/time_lib

ts=$(get_iso_timestamp)
              #  $1     $2   $3     $4   $5   $6    $7   $8
set_all_fnparts "srn" "raw" "hk" "elena" "-" "$ts" "csv" "_"

autoset_outdir
autoset_filename
get_filename
set_ext "xml";
get_filename
set_datatype "sc"
set_prodmode "s32"
set_ext "csv"
get_filename
set_ext "xml";
get_filename
set_prodmode "s16"
get_filename
set_ext "xml";
get_filename
set_prodmode "r"
get_filename
set_ext "xml";
get_filename

#    fp1     fp2       fp3    fp4      fp5       fp6   $7     $8(ps)
# plinstr_proclevel_datatype_plunit_prodmode_timestamp.ext      _
#
# srn_raw_sc_elena_s16_20181212t164352Z.xml
# srn_raw_sc_elena_s16_20181212t164352Z.csv
# srn_raw_sc_elena_s32_20181212t164352Z.xml
# srn_raw_sc_elena_s32_20181212t164352Z.csv
# srn_raw_sc_elena_s_20181212t164352Z.xml
# srn_raw_sc_elena_s_20181212t164352Z.csv
# srn_raw_sc_elena_s_20181212T164350.xml
# srn_raw_sc_elena_s_20181212T164350.csv
# srn_raw_sc_elena_r_20181214t164758Z.xml
# srn_raw_sc_elena_r_20181214t164758Z.csv
# srn_raw_sc_elena_r_20181214T164757.xml
# srn_raw_sc_elena_r_20181214T164757.csv
# srn_raw_hk_elena_20181212t084924Z.xml
# srn_raw_hk_elena_20181212t084924Z.csv
# srn_raw_hk_elena_20181212T084923.xml
# srn_raw_hk_elena_20181212T084923.csv
