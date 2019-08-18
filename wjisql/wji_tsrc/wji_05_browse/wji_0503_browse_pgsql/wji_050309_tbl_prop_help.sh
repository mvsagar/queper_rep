#
echo "-------------------------- TC 05/4.8 ----------------------"
echo "Tests table properties help"
echo ""
javac wji_050309_tbl_prop_help.java
java wji_050309_tbl_prop_help $WJI_URL 2> $TEST_DIR/wji_050309_tbl_prop_help.err
