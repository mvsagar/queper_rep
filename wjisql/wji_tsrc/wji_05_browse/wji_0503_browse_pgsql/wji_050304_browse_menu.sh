#
echo "-------------------------- TC 05/4.4.1/1,2 ----------------------"
echo "Tests Browse menu item"
echo ""
javac wji_050304_browse_menu.java
java wji_050304_browse_menu $WJI_URL 2> $TEST_DIR/wji_050304_browse_menu.err
