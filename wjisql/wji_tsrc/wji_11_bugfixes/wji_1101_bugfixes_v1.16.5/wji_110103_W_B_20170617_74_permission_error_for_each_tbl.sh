#
echo "-------------------------- TC 11/2.3/1 ----------------------"
echo "Tests fix for the bug W_B_20170617_74 - pgsql gives permission error for each table."
echo ""
javac wji_110103_W_B_20170617_74_permission_error_for_each_tbl.java
java wji_110103_W_B_20170617_74_permission_error_for_each_tbl $WJI_URL 2> $TEST_DIR/wji_110103_W_B_20170617_74_permission_error_for_each_tbl.err
