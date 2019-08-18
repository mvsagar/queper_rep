#
# ------------------------------ TPL-02-SECTION-4.1-TC-1 ----------------------------------
echo ""
echo "Test functionality of clicking of Release Notes in left pane on main screen"
echo ""
javac wji_0210_menuitem_relnotes.java
java wji_0210_menuitem_relnotes $WJI_URL 2> $TEST_DIR/wji_0210_menuitem_relnotes.err
