#!/bin/bash
# testing dataset lib functionalities
. lib/dataset_lib
i2=0
echo "# $i2 #### **** ####"; ((i2++))
set_matrix_size 1 4
push_row 1 2 3 4
push_row 5 6 7 8
push_row $RANDOM $RANDOM $RANDOM $RANDOM
push_row $RANDOM $RANDOM $RANDOM $RANDOM
push_row -1 -1 0 -1
print_csv_table
echo "# $i2 #### **** ####"; ((i2++))
insert_row 2 10 20 30 -10
print_csv_table
report_matrix