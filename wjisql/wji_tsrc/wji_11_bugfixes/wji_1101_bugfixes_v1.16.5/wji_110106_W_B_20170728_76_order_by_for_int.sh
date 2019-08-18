#
echo "-------------------------- TC 11/2.5/1 ----------------------"
echo "Tests fix for the bug W_B_20170728_76 - resultset rows are not as per order by clause, for int columns"
echo ""
javac wji_110106_W_B_20170728_76_order_by_for_int.java
java wji_110106_W_B_20170728_76_order_by_for_int $WJI_URL 2> $TEST_DIR/wji_110106_W_B_20170728_76_order_by_for_int.err
