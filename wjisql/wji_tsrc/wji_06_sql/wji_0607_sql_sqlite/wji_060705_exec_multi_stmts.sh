#
echo "-------------------------- TC 06/7.3.1/4 ----------------------"
echo "Tests execution of a multiple statements."
echo ""
javac wji_060705_exec_multi_stmts.java
java wji_060705_exec_multi_stmts $WJI_URL 2> $TEST_DIR/wji_060705_exec_multi_stmts.err
