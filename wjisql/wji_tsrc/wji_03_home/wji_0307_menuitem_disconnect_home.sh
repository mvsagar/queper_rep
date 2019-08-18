#
# ------------------------------ TC 03-2.1/7 ----------------------------------
echo ""
echo "Tests link 'Home' after link 'Disconnect' is clicked"
echo ""
javac wji_0307_menuitem_disconnect_home.java
java wji_0307_menuitem_disconnect_home $WJI_URL 2> $TEST_DIR/wji_0307_menuitem_disconnect_home.err
