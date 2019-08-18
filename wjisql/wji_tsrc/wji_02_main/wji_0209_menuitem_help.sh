#
# ------------------------------ TPL-02-SECTION-3.1-TC-8 ----------------------------------
echo ""
echo "Test functionality of clicking of DBMS Info link on main screen"
echo ""
javac wji_0209_menuitem_help.java
java wji_0209_menuitem_help $WJI_URL 2> $TEST_DIR/wji_0209_menuitem_help.err
