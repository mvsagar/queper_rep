#
echo "-------------------------- TC 05/4.11.1/1 ----------------------"
echo "Tests procedure/functions properties button 'Drop' for functions"
echo ""
javac wji_050313_func_drop.java
java wji_050313_func_drop $WJI_URL 2> $TEST_DIR/wji_050313_func_drop.err
