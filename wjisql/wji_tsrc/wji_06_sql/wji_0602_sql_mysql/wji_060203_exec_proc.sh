#
echo "-------------------------- TC 06/3.3.1/2 ----------------------"
echo "Tests execution of a procedure."
echo ""
javac wji_060203_exec_proc.java
java wji_060203_exec_proc $WJI_URL 2> $TEST_DIR/wji_060203_exec_proc.err
