#
# ------------------------------ TC 04-2.6.3 1 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid url prefix"
echo ""
javac wji_040603_unsucc_conn_with_inv_prefix_in_url.java
java wji_040603_unsucc_conn_with_inv_prefix_in_url $WJI_URL 2> $TEST_DIR/wji_040603_unsucc_conn_with_inv_prefix_in_url.err