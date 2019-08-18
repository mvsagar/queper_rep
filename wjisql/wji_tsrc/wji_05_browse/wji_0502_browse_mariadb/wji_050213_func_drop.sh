#
echo "-------------------------- TC 05/3.11.1/2 ----------------------"
echo "Tests procedure/functions properties button 'Drop' for functions"
echo ""
javac wji_050213_func_drop.java
java wji_050213_func_drop $WJI_URL 2> $TEST_DIR/wji_050213_func_drop.err
