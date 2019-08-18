#
echo "-------------------------- TC 07/3.2.1/3 ----------------------"
echo "Tests limiting of rows to be displayed using SELECT button in result frame."
echo ""
javac wji_070303_row_limit_sel.java
java wji_070303_row_limit_sel $WJI_URL 2> $TEST_DIR/wji_070303_row_limit_sel.err
