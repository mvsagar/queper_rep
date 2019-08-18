#
# ------------------------------ TC 03-2.1/2 ----------------------------------
echo ""
echo "Test functionality of clicking of Connect and Home link on main screen"
echo ""
javac wji_0302_menuitem_connect_home.java
java wji_0302_menuitem_connect_home $WJI_URL 2> $TEST_DIR/wji_0302_menuitem_connect_home.err
