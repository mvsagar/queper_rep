#
# ------------------------------ TC 03-2.1/6 ----------------------------------
echo ""
echo "Tests link 'Home' after link 'transfer' is clicked"
echo ""
javac wji_0306_menuitem_transfer_home.java
java wji_0306_menuitem_transfer_home $WJI_URL 2> $TEST_DIR/wji_0306_menuitem_transfer_home.err
