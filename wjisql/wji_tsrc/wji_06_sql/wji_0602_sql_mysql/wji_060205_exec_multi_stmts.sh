#
echo "-------------------------- TC 06/3.3.1/4 ----------------------"
echo "Tests execution of a multiple statements."
echo ""
javac wji_060205_exec_multi_stmts.java
java wji_060205_exec_multi_stmts $WJI_URL 2> $TEST_DIR/wji_060205_exec_multi_stmts.err
