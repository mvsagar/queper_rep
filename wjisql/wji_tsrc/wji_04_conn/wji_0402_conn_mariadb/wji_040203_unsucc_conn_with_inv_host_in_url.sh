#
# ------------------------------ TC 04-2.2.3 2 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid host in url"
echo ""
javac wji_040203_unsucc_conn_with_inv_host_in_url.java
java wji_040203_unsucc_conn_with_inv_host_in_url $WJI_URL 2> $TEST_DIR/wji_040203_unsucc_conn_with_inv_host_in_url.err