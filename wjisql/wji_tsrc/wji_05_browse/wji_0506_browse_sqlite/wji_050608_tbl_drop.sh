#
echo "-------------------------- TC 05/7.7.1/1 ----------------------"
echo "Tests table properties button 'Drop'"
echo ""
javac wji_050608_tbl_drop.java
java wji_050608_tbl_drop $WJI_URL 2> $TEST_DIR/wji_050608_tbl_drop.err
