#
echo "-------------------------- TC 05/3.4.1/1,2 ----------------------"
echo "Tests Table properties"
echo ""
javac wji_050105_tbl_prop.java
java wji_050105_tbl_prop $WJI_URL 2> $TEST_DIR/wji_050105_tbl_prop.err
