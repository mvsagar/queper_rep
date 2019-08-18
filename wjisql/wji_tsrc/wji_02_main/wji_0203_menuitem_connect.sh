#
# ------------------------------ TC 02-3.1/2 ----------------------------------
echo ""
echo "Test functionality of clicking of Connect link on main screen"
echo ""
javac wji_0203_menuitem_connect.java
java wji_0203_menuitem_connect $WJI_URL 2> $TEST_DIR/wji_0203_menuitem_connect.err
