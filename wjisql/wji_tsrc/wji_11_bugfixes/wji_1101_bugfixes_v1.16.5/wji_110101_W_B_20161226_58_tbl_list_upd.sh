#
echo "-------------------------- TC 11/2.1/1 ----------------------"
echo "Tests fix for the bug W_B_20161226_58 - table refresh after data transfer does not happen."
echo ""
javac wji_110101_W_B_20161226_58_tbl_list_upd.java
java wji_110101_W_B_20161226_58_tbl_list_upd $WJI_URL pgsql 2> $TEST_DIR/wji_110101_W_B_20161226_58_tbl_list_upd.err
