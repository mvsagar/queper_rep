#
echo "-------------------------- TC 06/3.2.1/1 ----------------------"
echo "Tests SQL menu item using FireFox."
echo ""
javac wji_060201_sql_menu_item.java
java wji_060201_sql_menu_item $WJI_URL 2> $TEST_DIR/wji_060201_sql_menu_item.err
