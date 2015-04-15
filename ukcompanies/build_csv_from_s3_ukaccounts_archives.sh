#!/bin/sh
set -e

if test $# -lt 2; then
	echo "Usage: $0 S3_DIR_URI YYYY-MM ..."
	exit 1
fi

SCRIPT_DIR=`dirname $0`

S3_DIR_URI=$1
shift

while test $# -ne 0; do
	MONTH=$1
	BASENAME="Accounts_Monthly_Data-${MONTH}"
	s3cmd get "${S3_DIR_URI}/${BASENAME}.zip"
	mkdir "${BASENAME}"
	cd "${BASENAME}"
	unzip -q "../${BASENAME}.zip"
	cd ..
	"$SCRIPT_DIR"/uk-gaap-ixbrl2csv_parallel.sh "${BASENAME}" 8 > "${BASENAME}.csv"
	gzip "${BASENAME}.csv"
	rm -rf "${BASENAME}"
	rm "${BASENAME}.zip"

	shift
done
