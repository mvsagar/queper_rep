#
echo "-------------------------- TC 11/2.4/1 ----------------------"
echo "Tests fix for the bug W_B_20170711_75 - script loading second time fails."
echo ""
javac wji_110104_W_B_20170711_75_script_loading_2nd_time_fails.java
java wji_110104_W_B_20170711_75_script_loading_2nd_time_fails $WJI_URL 2> $TEST_DIR/wji_110104_W_B_20170711_75_script_loading_2nd_time_fails.err
