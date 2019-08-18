#
echo "-------------------------- TC 05/3.11.1/1 ----------------------"
echo "Tests procedure/functions properties button 'Drop' for procedures"
echo ""
javac wji_050212_proc_drop.java
java wji_050212_proc_drop $WJI_URL 2> $TEST_DIR/wji_050212_proc_drop.err
