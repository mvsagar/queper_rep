#
# ------------------------------ TC 04-2.2.3 5 ----------------------------------
echo ""
echo "Tests Unsuccessful connection with invalid password in url"
echo ""
javac wji_040306_unsucc_conn_with_inv_passwd_in_url.java
java wji_040306_unsucc_conn_with_inv_passwd_in_url $WJI_URL 2> $TEST_DIR/wji_040306_unsucc_conn_with_inv_passwd_in_url.err
