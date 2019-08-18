currdir=`pwd`
. $WJI_TSRC_HOME/setup.env
. $WJI_TSRC_HOME/setup.mysql
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0501_browse_mysql
run_tests.sh mysqlusr mysql123 mysqldb test_list_dbsetup.txt
cd $currdir
echo "2. Running tests..."
run_tests.sh mysqlusr mysql123 mysqldb
