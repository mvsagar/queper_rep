#
# ------------------------------ TC 04-2.6.2 3 ----------------------------------
echo ""
echo "Tests successful connection with chosen db file"
echo ""
javac wji_040602_succ_conn_with_chosen_db_file.java
java wji_040602_succ_conn_with_chosen_db_file $WJI_URL 2> $TEST_DIR/wji_040602_succ_conn_with_chosen_db_file.err
