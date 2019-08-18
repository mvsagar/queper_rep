#
echo "-------------------------- TC 11/2.6/5 ----------------------"
echo "Tests fix for the bug W_B_20190806_91: Clicking of transfer check box in table header of source table list in Data Transfer screen is problematic."
echo ""
javac wji_110205_W_B_20190806_91_xfr_tbl_hdr_chkbox_click.java
java wji_110205_W_B_20190806_91_xfr_tbl_hdr_chkbox_click $WJI_URL 2> $TEST_DIR/wji_110205_W_B_20190806_91_xfr_tbl_hdr_chkbox_click.err
