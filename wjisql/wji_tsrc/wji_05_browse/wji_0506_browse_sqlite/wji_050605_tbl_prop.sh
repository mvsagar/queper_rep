#
echo "-------------------------- TC 05/7.4.1/1,2 ----------------------"
echo "Tests Table properties"
echo ""
javac wji_050605_tbl_prop.java
java wji_050605_tbl_prop $WJI_URL 2> $TEST_DIR/wji_050605_tbl_prop.err
