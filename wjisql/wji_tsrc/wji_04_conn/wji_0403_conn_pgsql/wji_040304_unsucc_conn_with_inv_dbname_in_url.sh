#
# ------------------------------ TC 04-2.3.3 3 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid db name in url"
echo ""
javac wji_040304_unsucc_conn_with_inv_dbname_in_url.java
java wji_040304_unsucc_conn_with_inv_dbname_in_url $WJI_URL 2> $TEST_DIR/wji_040304_unsucc_conn_with_inv_dbname_in_url.err
