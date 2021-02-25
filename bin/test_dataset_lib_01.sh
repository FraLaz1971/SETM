#!/bin/bash
# testing dataset lib functionalities
. lib/dataset_lib
i2=0
echo "# $i2 #### **** ####"; ((i2++))
set_random_matrix $@
print_matrix
echo "# $i2 #### **** ####"; ((i2++))
print_csv_table
# echo "# $i2 #### **** ####"; ((i2++))
# set_matrix_size $@
# print_matrix
# echo "# $i2 #### **** ####"; ((i2++))
# print_csv_table
echo "# $i2 NOW pushing 2 rows! #### **** ####"; ((i2++))

debug "next row index $maxrow"
push_row 1 2 3
debug "next row index $maxrow"
push_row 6 67 44
debug "next row index $maxrow"
push_row -2 -6 12556
print_matrix
echo "# $i2 #### **** ####"; ((i2++))
print_csv_table
echo "# $i2 #### **** ####"; ((i2++))
report_matrix