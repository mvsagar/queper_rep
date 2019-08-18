#
echo "-------------------------- TC 08/3.6.1/1 ----------------------"
echo "Tests clearing of row selection"
echo ""
javac wji_080210_row_selection_clear.java
java wji_080210_row_selection_clear $WJI_URL 2> $TEST_DIR/wji_080210_row_selection_clear.err
