#
# ------------------------------ TC 03-2.1/1 ----------------------------------
echo ""
echo "Test functionality of clicking of Home link on main screen"
echo ""
javac wji_0301_menuitem_home.java
java wji_0301_menuitem_home $WJI_URL 2> $TEST_DIR/wji_0301_menuitem_home.err
