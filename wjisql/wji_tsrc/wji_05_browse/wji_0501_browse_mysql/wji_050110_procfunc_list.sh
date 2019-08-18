#
echo "-------------------------- TC 05/3.9.1/1 ----------------------"
echo "Tests Procedures & Functions button"
echo ""
javac wji_050110_procfunc_list.java
java wji_050110_procfunc_list $WJI_URL 2> $TEST_DIR/wji_050110_procfunc_list.err
