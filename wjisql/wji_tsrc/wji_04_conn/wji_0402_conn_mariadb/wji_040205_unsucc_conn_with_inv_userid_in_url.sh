#
# ------------------------------ TC 04-2.2.3 4 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid user id in url"
echo ""
javac wji_040205_unsucc_conn_with_inv_userid_in_url.java
java wji_040205_unsucc_conn_with_inv_userid_in_url $WJI_URL 2> $TEST_DIR/wji_040205_unsucc_conn_with_inv_userid_in_url.err
