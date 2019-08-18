#
# ------------------------------ TPL-02-SECTION-3.1-TC-7 ----------------------------------
echo ""
echo "Test functionality of clicking of DBMS Info link on main screen"
echo ""
javac wji_0208_menuitem_dbmsinfo.java
java wji_0208_menuitem_dbmsinfo $WJI_URL 2> $TEST_DIR/wji_0208_menuitem_dbmsinfo.err
