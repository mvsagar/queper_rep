#
echo "-------------------------- TC 08/3.5.2/1 ----------------------"
echo "Tests failure of deletion of data"
echo ""
javac wji_080308_deletion_failure.java
java wji_080308_deletion_failure $WJI_URL 2> $TEST_DIR/wji_080308_deletion_failure.err
