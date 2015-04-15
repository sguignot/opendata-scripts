#!/bin/sh

if test $# -lt 2; then
	echo "Usage: $0 dirname njobs"
	exit 1
fi

SCRIPT_DIR=`dirname $0`
find "$1" -name '*.html' | parallel -j "$2" "$SCRIPT_DIR"/uk-gaap-ixbrl2csv.sh '{}'
