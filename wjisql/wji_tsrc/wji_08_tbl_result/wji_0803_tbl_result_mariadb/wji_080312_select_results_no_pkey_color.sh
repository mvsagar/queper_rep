#
echo "-------------------------- TC 08/3.8.1/1 ----------------------"
echo "Tests select button results in no color for primary key columns"
echo ""
javac wji_080312_select_results_no_pkey_color.java
java wji_080312_select_results_no_pkey_color $WJI_URL 2> $TEST_DIR/wji_080312_select_results_no_pkey_color.err
