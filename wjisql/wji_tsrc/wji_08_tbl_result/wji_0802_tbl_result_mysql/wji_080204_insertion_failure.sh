#
echo "-------------------------- TC 08/3.3.1/2 ----------------------"
echo "Tests failure of insertion of data"
echo ""
javac wji_080204_insertion_failure.java
java wji_080204_insertion_failure $WJI_URL 2> $TEST_DIR/wji_080204_insertion_failure.err
