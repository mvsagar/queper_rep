#
echo "-------------------------- TC 05/3.5.1/1,2,3 ----------------------"
echo "Tests table button Data"
echo ""
javac wji_050106_tbl_data.java
java wji_050106_tbl_data $WJI_URL 2> $TEST_DIR/wji_050106_tbl_data.err
