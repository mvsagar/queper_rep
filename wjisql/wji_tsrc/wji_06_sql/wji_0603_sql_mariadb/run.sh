currdir=`pwd`
. ../../setup.env
. ../../setup.mariadb
echo "1. Setting up database..."
cd $WJI_TSRC_HOME/wji_05_browse/wji_0502_browse_mariadb
run_tests.sh mariausr maria123 mariadb test_list_dbsetup.txt
cd $currdir
echo "2. Running tests..."
run_tests.sh mariausr maria123 mariadb
