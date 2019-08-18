#
echo "-------------------------- TC 08/3.4.1/2 ----------------------"
echo "Tests failure of update of data"
echo ""
javac wji_080206_update_failure.java
java wji_080206_update_failure $WJI_URL 2> $TEST_DIR/wji_080206_update_failure.err
