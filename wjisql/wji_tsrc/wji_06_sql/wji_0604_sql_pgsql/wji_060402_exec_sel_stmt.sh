#
echo "-------------------------- TC 06/3.3.1/1 ----------------------"
echo "Tests execution of a select statement."
echo ""
javac wji_060402_exec_sel_stmt.java
java wji_060402_exec_sel_stmt $WJI_URL 2> $TEST_DIR/wji_060402_exec_sel_stmt.err
