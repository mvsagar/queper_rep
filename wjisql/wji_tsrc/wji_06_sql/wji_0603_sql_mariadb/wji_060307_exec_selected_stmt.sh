#
echo "-------------------------- TC 06/3.5.1/1 ----------------------"
echo "Tests execution of selected statement."
echo ""
javac wji_060307_exec_selected_stmt.java
java wji_060307_exec_selected_stmt $WJI_URL 2> $TEST_DIR/wji_060307_exec_selected_stmt.err
