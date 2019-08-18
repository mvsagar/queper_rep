#
# ------------------------------ TC 03-2.1/3 ----------------------------------
echo ""
echo "Test functionality of clicking of Connect, login and Home links on main screen"
echo ""
javac wji_0303_menuitem_login_home.java
java wji_0303_menuitem_login_home $WJI_URL 2> $TEST_DIR/wji_0303_menuitem_login_home.err
