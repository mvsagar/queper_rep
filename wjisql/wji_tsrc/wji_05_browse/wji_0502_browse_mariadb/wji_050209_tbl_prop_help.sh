#
echo "-------------------------- TC 05/3.8.1/1 ----------------------"
echo "Tests table properties help"
echo ""
javac wji_050209_tbl_prop_help.java
java wji_050209_tbl_prop_help $WJI_URL 2> $TEST_DIR/wji_050209_tbl_prop_help.err
