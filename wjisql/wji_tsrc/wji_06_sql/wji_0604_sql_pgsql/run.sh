currdir=`pwd`
. ../../setup.env
. ../../setup.pgsql
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0503_browse_pgsql
run_tests.sh pgsqlusr pgsql123 pgsqldb test_list_dbsetup.txt
cd $currdir
echo "2. Running tests..."
run_tests.sh pgsqlusr pgsql123 pgsqldb
