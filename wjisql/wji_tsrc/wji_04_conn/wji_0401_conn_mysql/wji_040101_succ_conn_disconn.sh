#
# ------------------------------ TC 04-2.2.2 1 & 2 ----------------------------------
echo ""
echo "Tests Successful connection and disconnection"
echo ""
javac wji_040101_succ_conn_disconn.java
java wji_040101_succ_conn_disconn $WJI_URL 2> $TEST_DIR/wji_040101_succ_conn_disconn.err
