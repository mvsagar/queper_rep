#
echo "-------------------------- TC 11/2.6/5 ----------------------"
echo "Tests fix for the bug W_B_20180911_88: Table list scroll position changes when select stmt is executed."
echo ""
javac wji_110204_W_B_20180911_88_tbl_list_scroll_position_changes.java
java wji_110204_W_B_20180911_88_tbl_list_scroll_position_changes $WJI_URL 2> $TEST_DIR/wji_110204_W_B_20180911_88_tbl_list_scroll_position_changes.err
