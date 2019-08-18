#
echo "-------------------------- TC 05/3.13.1/1 ----------------------"
echo "Tests button 'Tables' in procedure/function list frame."
echo ""
javac wji_050115_procfunc_tbls.java
java wji_050115_procfunc_tbls $WJI_URL 2> $TEST_DIR/wji_050115_procfunc_tbls.err
