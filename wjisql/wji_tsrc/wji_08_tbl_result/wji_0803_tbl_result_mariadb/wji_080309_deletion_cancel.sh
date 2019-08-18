#
echo "-------------------------- TC 08/3.5.2/2 ----------------------"
echo "Tests cancelation of deletion of data"
echo ""
javac wji_080309_deletion_cancel.java
java wji_080309_deletion_cancel $WJI_URL 2> $TEST_DIR/wji_080309_deletion_cancel.err
