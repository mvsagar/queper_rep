#
echo "-------------------------- TC 08/3.9.2/1 ----------------------"
echo "Tests Cancellation of Delete All to delete all rows."
echo ""
javac wji_080314_delete_all_cancel.java
java wji_080314_delete_all_cancel $WJI_URL 2> $TEST_DIR/wji_080314_delete_all_cancel.err