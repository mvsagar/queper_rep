#
echo "-------------------------- TC 08/3.10.1/5 ----------------------"
echo "Tests Cancellation of Delete operation."
echo ""
javac wji_080319_cancel_delete.java
java wji_080319_cancel_delete $WJI_URL 2> $TEST_DIR/wji_080319_cancel_delete.err