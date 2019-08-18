#
# ------------------------------ TC 02-3.1/4 ----------------------------------
echo ""
echo "Test functionality of clicking of Browse link on main screen"
echo ""
javac wji_0205_menuitem_browse.java
java wji_0205_menuitem_browse $WJI_URL 2> $TEST_DIR/wji_0205_menuitem_browse.err
