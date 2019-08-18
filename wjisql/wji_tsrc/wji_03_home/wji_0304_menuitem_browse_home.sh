#
# ------------------------------ TC 03-2.1/4 ----------------------------------
echo ""
echo "Test functionality of Home link from browsing screen"
echo ""
javac wji_0304_menuitem_browse_home.java
java wji_0304_menuitem_browse_home $WJI_URL 2> $TEST_DIR/wji_0304_menuitem_browse_home.err
