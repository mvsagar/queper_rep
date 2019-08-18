#
echo "-------------------------- TC 11/2.6/3 ----------------------"
echo "Tests fix for the bug W_B_20180911_87: error on switching to procedures/functions."
echo ""
javac wji_110203_W_B_20180911_87_error_on_switching_to_procs.java
java wji_110203_W_B_20180911_87_error_on_switching_to_procs $WJI_URL 2> $TEST_DIR/wji_110203_W_B_20180911_87_error_on_switching_to_procs.err
