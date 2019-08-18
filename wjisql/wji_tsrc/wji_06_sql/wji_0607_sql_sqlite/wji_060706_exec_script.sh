#
echo "-------------------------- TC 06/7.4.1/1 ----------------------"
echo "Tests execution of SQL script."
echo ""
javac wji_060706_exec_script.java
java wji_060706_exec_script $WJI_URL 2> $TEST_DIR/wji_060706_exec_script.err
