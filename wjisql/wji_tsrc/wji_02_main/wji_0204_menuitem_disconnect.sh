#
# ------------------------------ TC 02-3.1/3 ----------------------------------
echo ""
echo "Test functionality of clicking of Disconnect link on main screen"
echo ""
javac wji_0204_menuitem_disconnect.java
java wji_0204_menuitem_disconnect $WJI_URL 2> $TEST_DIR/wji_0204_menuitem_disconnect.err
