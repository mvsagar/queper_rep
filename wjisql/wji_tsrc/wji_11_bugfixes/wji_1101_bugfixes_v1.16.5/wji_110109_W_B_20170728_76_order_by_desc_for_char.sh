#
echo "-------------------------- TC 11/2.5/4 ----------------------"
echo "Tests fix for the bug W_B_20170728_76 - resultset rows are not as per order by clause, for char columns in descending order"
echo ""
javac wji_110109_W_B_20170728_76_order_by_desc_for_char.java
java wji_110109_W_B_20170728_76_order_by_desc_for_char $WJI_URL 2> $TEST_DIR/wji_110109_W_B_20170728_76_order_by_desc_for_char.err
