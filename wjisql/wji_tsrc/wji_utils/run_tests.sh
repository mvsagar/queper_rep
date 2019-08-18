#!/bin/bash
# Version	Date		Description
# -------	----		-----------
# 1.0.0.1       2018-04-10	Created from old one
# 1.0.0.2   	2019-07-20	Changed success/failure message.
# 1.0.0.3	2019-08-01	Added new argument save-file-ext to support extensions
#				other than 'sav'.
# -------	----		-----------


function run_a_test()
{

    sh ${test_file}.sh ${db_user_name} ${db_user_passwd} ${db_name} ${db_option} > $TEST_DIR/${test_file}.out
    sed -e 's/IP address: .*,/IP address: <ipaddr>,/' \
	    -e 's/at .* for/at <ipaddr> for/' -e 's/ts=.*,/<ts>,/' \
	    -e 's/, ts=.*/, <ts>/' \
	    -e 's/length:.*,/length:<ts>,/' \
	    -e 's/(conn=.*)//' \
	    $TEST_DIR/${test_file}.out >  $TEST_DIR/${test_file}.out.tmp
    if [ -f ${test_file}.${save_file_ext} ]
    then 
	test_save_file="${test_file}.${save_file_ext}"
    else
	# Standard save file.
	test_save_file="${test_file}.sav"
    fi
    sed -e 's/IP address: .*,/IP address: <ipaddr>,/' \
	    -e 's/at .* for/at <ipaddr> for/' \
	    -e 's/ts=.*,/<ts>,/' -e 's/, ts=.*/, <ts>/' \
	    -e 's/length:.*,/length:<ts>,/' \
	    -e 's/(conn=.*)//' \
	    ${test_save_file} >  $TEST_DIR/${test_save_file}.tmp
    if (diff $TEST_DIR/${test_save_file}.tmp $TEST_DIR/${test_file}.out.tmp > $TEST_DIR/${test_file}.dif)
    then
        echo "${test_file}.sh: SUCCESS..."
        echo "${test_file}.sh: SUCCESS..." >> $TEST_DIR/${trr_file}
    else
        echo "${test_file}.sh: FAILED..."
        echo "${test_file}.sh: FAILED..." >> $TEST_DIR/${trr_file}
        test_status="failure"
    fi
}

function run_all_tests()
{

    tsrc_dir=$(basename `pwd`)
    trr_file="trr_${tsrc_dir}.rpt" 
    if [ -e $TEST_DIR/$trr_file ]
    then
        cp $TEST_DIR/${trr_file} $TEST_DIR/${trr_file}.bak
    fi

    echo ""
    date 
    date >> $TEST_DIR/${trr_file}
    echo ""

    # Common setting for all tests.
    test_status="success"

    while IFS= read -r test_file
    do
      if [[ $test_file == "# "* ]]; then
         echo this is a comment > /dev/null
      elif [[ $test_file == "#"* ]]; then
          echo "Skipping test $test_file..."
      else    
          run_a_test
      fi
    done < "$test_list_file"


    echo ""
    echo >> $TEST_DIR/${trr_file}
    echo "Completed tests..."
    echo "Completed tests..." >> $TEST_DIR/${trr_file}
    date 
    date >> $TEST_DIR/${trr_file}

    echo "-----------------------"
    echo "-----------------------" >> $TEST_DIR/${trr_file}

    if test $test_status ==  "success" 
    then 
        echo "Test is SUCCESSFUL."
        echo "Test is SUCCESSFUL." >> $TEST_DIR/${trr_file}
    else
        echo "Test FAILED."
        echo "Test FAILED." >> $TEST_DIR/${trr_file}
    fi

    echo "-----------------------"
    echo "-----------------------" >> $TEST_DIR/${trr_file}


    echo ""
    echo "Test status is available in file $TEST_DIR/${trr_file}..."
    echo ""
}

if [[ $# -lt 3 || $# -gt 5 ]]
then
    echo ""
    echo "Error: Invalid arguments..."
    echo ""
    echo "Usage: sh run_tests.sh <db-user-id>  <db-user-password> <db-name> [<test-list-file> [<save-file-ext>[mariadb-defaults option]]]"
    echo "	"
    echo "    Example mariadb_default option: --defaults-extra-file=/opt/mariadb-data/my.cnf"
    exit 1
fi
db_user_name="$1"
db_user_passwd="$2"
db_name="$3"
if [[ $# -ge 4 ]]
then 
    test_list_file="$4"
else
    test_list_file="./test_list.txt"
fi
if [[ $# -ge 5 ]]
then
    save_file_ext="$5"
else
    save_file_ext="sav"
fi
if [[ $# -ge 6 ]]
then
    db_option="$6"
else
    db_option=""
fi

mkdir -p $TEST_DIR

# Call main function
run_all_tests

