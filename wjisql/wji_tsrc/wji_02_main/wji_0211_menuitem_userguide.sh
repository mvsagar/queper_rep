#
# ------------------------------ TPL-02-SECTION-4.1-TC-2 ----------------------------------
echo ""
echo "Test functionality of clicking of User's Guide in left pane on main screen"
echo ""
javac wji_0211_menuitem_userguide.java
java wji_0211_menuitem_userguide $WJI_URL 2> $TEST_DIR/wji_0211_menuitem_userguide.err
