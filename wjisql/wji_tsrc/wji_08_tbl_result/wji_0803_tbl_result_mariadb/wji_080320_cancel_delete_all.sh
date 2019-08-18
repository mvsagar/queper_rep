#
echo "-------------------------- TC 08/3.10.1/6 ----------------------"
echo "Tests Cancellation of Delete All operation."
echo ""
javac wji_080320_cancel_delete_all.java
java wji_080320_cancel_delete_all $WJI_URL 2> $TEST_DIR/wji_080320_cancel_delete_all.err