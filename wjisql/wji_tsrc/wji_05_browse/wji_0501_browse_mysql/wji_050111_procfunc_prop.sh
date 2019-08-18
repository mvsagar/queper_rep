#
echo "-------------------------- TC 05/3.10.1/1,2,3 ----------------------"
echo "Tests Procedure/Function Properties"
echo ""
javac wji_050111_procfunc_prop.java
java wji_050111_procfunc_prop $WJI_URL 2> $TEST_DIR/wji_050111_procfunc_prop.err
