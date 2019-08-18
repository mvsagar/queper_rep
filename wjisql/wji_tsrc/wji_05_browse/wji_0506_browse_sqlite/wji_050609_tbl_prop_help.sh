#
echo "-------------------------- TC 05/7.8.1/1 ----------------------"
echo "Tests table properties help"
echo ""
javac wji_050609_tbl_prop_help.java
java wji_050609_tbl_prop_help $WJI_URL 2> $TEST_DIR/wji_050609_tbl_prop_help.err
