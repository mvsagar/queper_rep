#
echo "-------------------------- TC 06/3.3.1/3 ----------------------"
echo "Tests execution of a function."
echo ""
javac wji_060204_exec_func.java
java wji_060204_exec_func $WJI_URL 2> $TEST_DIR/wji_060204_exec_func.err
