#
# ------------------------------ TPL-02-SECTION-4.1-TC-3 ----------------------------------
echo ""
echo "Test functionality of clicking of About in left pane on main screen"
echo ""
javac wji_0212_menuitem_about.java
java wji_0212_menuitem_about $WJI_URL 2> $TEST_DIR/wji_0212_menuitem_about.err
