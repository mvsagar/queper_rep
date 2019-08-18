currdir=`pwd`
. ../../setup.env
. ../../setup.sqlite
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0506_browse_sqlite
run_tests.sh abc xyz sqlitedb test_list_dbsetup.txt
cd $currdir
echo "2. Running tests..."
run_tests.sh abc xyz sqlitedb
