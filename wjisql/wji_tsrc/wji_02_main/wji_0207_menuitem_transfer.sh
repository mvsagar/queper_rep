#
# ------------------------------ TPL-02-SECTION-3.1-TC-6 ----------------------------------
echo ""
echo "Test functionality of clicking of Transfer link on main screen"
echo ""
javac wji_0207_menuitem_transfer.java
java wji_0207_menuitem_transfer $WJI_URL 2> $TEST_DIR/wji_0207_menuitem_transfer.err
