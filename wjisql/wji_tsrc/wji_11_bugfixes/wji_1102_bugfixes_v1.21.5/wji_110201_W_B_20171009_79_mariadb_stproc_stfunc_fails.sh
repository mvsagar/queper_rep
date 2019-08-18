#
echo "-------------------------- TC 11/2.6/1 ----------------------"
echo "Tests fix for the bug W_B_20171009_79: Stored procedure and function creation fails in MariaDB."
echo ""
javac wji_110201_W_B_20171009_79_mariadb_stproc_stfunc_fails.java
java wji_110201_W_B_20171009_79_mariadb_stproc_stfunc_fails $WJI_URL 2> $TEST_DIR/wji_110201_W_B_20171009_79_mariadb_stproc_stfunc_fails.err
