#
echo "-------------------------- TC 06/3.5.1/2 ----------------------"
echo "Tests execution of multiple selected statements."
echo ""
javac wji_060208_exec_multiple_selected_stmts.java
java wji_060208_exec_multiple_selected_stmts $WJI_URL 2> $TEST_DIR/wji_060208_exec_multiple_selected_stmts.err
