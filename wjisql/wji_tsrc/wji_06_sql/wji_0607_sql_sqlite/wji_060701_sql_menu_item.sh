#
echo "-------------------------- TC 06/7.2.1/1 ----------------------"
echo "Tests SQL menu item using Chorme."
echo ""
javac wji_060701_sql_menu_item.java
java wji_060701_sql_menu_item $WJI_URL 2> $TEST_DIR/wji_060701_sql_menu_item.err
