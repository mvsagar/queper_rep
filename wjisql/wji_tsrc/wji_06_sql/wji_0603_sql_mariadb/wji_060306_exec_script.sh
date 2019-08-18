#
echo "-------------------------- TC 06/3.4.1/1 ----------------------"
echo "Tests execution of SQL script."
echo ""
javac wji_060306_exec_script.java
java wji_060306_exec_script $WJI_URL 2> $TEST_DIR/wji_060306_exec_script.err
