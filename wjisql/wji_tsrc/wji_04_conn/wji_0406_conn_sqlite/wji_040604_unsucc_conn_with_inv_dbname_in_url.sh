#
# ------------------------------ TC 04-2.6.3 2 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid db name in url"
echo ""
javac wji_040604_unsucc_conn_with_inv_dbname_in_url.java
java wji_040604_unsucc_conn_with_inv_dbname_in_url $WJI_URL 2> $TEST_DIR/wji_040604_unsucc_conn_with_inv_dbname_in_url.err
