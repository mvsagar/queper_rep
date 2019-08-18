#
echo "-------------------------- TC 11/2.4/2 ----------------------"
echo "Tests fix for the bug W_B_20170711_75 - script loading second time fails after clearing stmt area."
echo ""
javac wji_110105_W_B_20170711_75_script_loading_2nd_time_fails.java
java wji_110105_W_B_20170711_75_script_loading_2nd_time_fails $WJI_URL 2> $TEST_DIR/wji_110105_W_B_20170711_75_script_loading_2nd_time_fails.err
