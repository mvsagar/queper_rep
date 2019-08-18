#
echo "-------------------------- TC 07/3.2.1/1 ----------------------"
echo "Tests SELECT statement to display all rows from table emp."
echo ""
javac wji_070301_exec_sel_stmt.java
java wji_070301_exec_sel_stmt $WJI_URL 2> $TEST_DIR/wji_070301_exec_sel_stmt.err
