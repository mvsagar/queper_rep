#
echo "-------------------------- TC 06/4.5.1/1 ----------------------"
echo "Tests execution of selected statement."
echo ""
javac wji_060407_exec_selected_stmt.java
java wji_060407_exec_selected_stmt $WJI_URL 2> $TEST_DIR/wji_060407_exec_selected_stmt.err
