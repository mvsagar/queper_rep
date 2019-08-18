#
# ------------------------------ TC 01-2.1/1 ----------------------------------
echo ""
echo " Test successful installation of wjISQL"
echo ""
if [ "$TOMCAT" = "" ]; then
    echo "TOMCAT environment variable is not set."
    exit 101
fi
if [ "$WJI_TSRC_HOME" = "" ]; then
    echo "WJI_TSRC_HOME environment variable is not set."
    exit 102
fi

cd $TOMCAT
./bin/shutdown.sh
rm -rf work webapps/wjisql*
cd webapps
if  [ -f ${WJI_DIST}/wjisql.war ]; then
    cp  $WJI_DIST/wjisql.war .
    echo "Copied wjisq.jar to webapps..."
else 
    echo "ERROR: wjisql.jar file not found in ${WJI_DIST}."
    exit 103
fi
cd ..
./bin/startup.sh
echo "---pass if tomcat is started after copying new wjisql.jar"
