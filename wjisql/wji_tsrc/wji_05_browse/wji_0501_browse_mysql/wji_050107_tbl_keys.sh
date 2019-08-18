#
echo "-------------------------- TC 05/3.6.1/1 ----------------------"
echo "Tests table properties button 'Keys'"
echo ""
javac wji_050107_tbl_keys.java
java wji_050107_tbl_keys $WJI_URL 2> $TEST_DIR/wji_050107_tbl_keys.err
