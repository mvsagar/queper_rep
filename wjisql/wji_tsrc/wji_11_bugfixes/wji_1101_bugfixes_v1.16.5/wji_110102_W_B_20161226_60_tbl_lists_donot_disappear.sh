#
echo "-------------------------- TC 11/2.2/1 ----------------------"
echo "Tests fix for the bug W_B_20161226_60 - table lists do not disappear after disconnections."
echo ""
javac wji_110102_W_B_20161226_60_tbl_lists_donot_disappear.java
java wji_110102_W_B_20161226_60_tbl_lists_donot_disappear $WJI_URL pgsql 2> $TEST_DIR/wji_110102_W_B_20161226_60_tbl_lists_donot_disappear.err
