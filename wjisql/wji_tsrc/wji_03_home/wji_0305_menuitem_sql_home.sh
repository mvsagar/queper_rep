#
# ------------------------------ TC 03-2.1/5 ----------------------------------
echo ""
echo "Tests link 'Home' after link 'SQL' is clicked"
echo ""
javac wji_0305_menuitem_sql_home.java
java wji_0305_menuitem_sql_home $WJI_URL 2> $TEST_DIR/wji_0305_menuitem_sql_home.err
