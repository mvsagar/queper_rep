#
echo "-------------------------- TC 06/7.3.1/1 ----------------------"
echo "Tests execution of a select statement."
echo ""
javac wji_060702_exec_sel_stmt.java
java wji_060702_exec_sel_stmt $WJI_URL 2> $TEST_DIR/wji_060702_exec_sel_stmt.err
