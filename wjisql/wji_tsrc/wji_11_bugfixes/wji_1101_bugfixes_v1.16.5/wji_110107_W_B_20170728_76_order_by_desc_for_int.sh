#
echo "-------------------------- TC 11/2.5/2 ----------------------"
echo "Tests fix for the bug W_B_20170728_76 - resultset rows are not as per order by clause, for int columns in descending order"
echo ""
javac wji_110107_W_B_20170728_76_order_by_desc_for_int.java
java wji_110107_W_B_20170728_76_order_by_desc_for_int $WJI_URL 2> $TEST_DIR/wji_110107_W_B_20170728_76_order_by_desc_for_int.err
