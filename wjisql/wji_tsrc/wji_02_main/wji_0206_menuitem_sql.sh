#
# ------------------------------ TC 02-3.1/5 ----------------------------------
echo ""
echo "Test functionality of clicking of SQL link on main screen"
echo ""
javac wji_0206_menuitem_sql.java
java wji_0206_menuitem_sql $WJI_URL 2> $TEST_DIR/wji_0206_menuitem_sql.err
