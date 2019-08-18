#
# ------------------------------ TC 04-2.6.3 3 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid db file"
echo ""
javac wji_040605_unsucc_conn_with_inv_db_file.java
java wji_040605_unsucc_conn_with_inv_db_file $WJI_URL 2> $TEST_DIR/wji_040605_unsucc_conn_with_inv_db_file.err
