#
# ------------------------------ TC 01-2.1/2 ----------------------------------
echo ""
echo " Test invoking wjISQL in chrome browser"
echo ""
javac wji_0102_invoke_in_chrome.java
java wji_0102_invoke_in_chrome $WJI_URL 2> /dev/null
