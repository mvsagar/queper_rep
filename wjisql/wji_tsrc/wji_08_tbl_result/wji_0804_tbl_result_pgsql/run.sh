curr_dir=`pwd`
. $WJI_TSRC_HOME/setup.env
. $WJI_TSRC_HOME/setup.pgsql
cd $WJI_TEST_HOME
# Save mariadb report as we use tests of mariadb for pgsql.
if [ -f trr_wji_0803_tbl_result_mariadb.rpt ]
then
    mv -f trr_wji_0803_tbl_result_mariadb.rpt trr_wji_0803_tbl_result_mariadb.rpt.bkp
fi
cd $curr_dir
# Run tests for mariadb as they work for pgsql as well.
cd ../wji_0803_tbl_result_mariadb
run_tests.sh pgsqlusr pgsql123 pgsqldb test_list.txt pgsql
cd $WJI_TEST_HOME
# Save report as pgsql report.
mv -f trr_wji_0803_tbl_result_mariadb.rpt trr_wji_0804_tbl_result_pgsql.rpt
# Restore mariadb report.
if [ -f trr_wji_0803_tbl_result_mariadb.rpt.bkp ]
then
    mv -f trr_wji_0803_tbl_result_mariadb.rpt.bkp trr_wji_0803_tbl_result_mariadb.rpt
fi
# Come back to pgsql tsrc directory.
cd $curr_dir
