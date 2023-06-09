#!/bin/bash

basedir="$(dirname $0)"
SCRIPT_COMMON=common.sh
if [ -f "${basedir}/${SCRIPT_COMMON}" ]; then
	. "${basedir}/${SCRIPT_COMMON}"
else
	echo "Missing helper script ${SCRIPT_COMMON}" && exit 1
fi

set -x

while :; do
	let loops=$(( $RANDOM % 256 ))
	for ((i=0; i< ${loops} ; i++)) ; do
		wait_for_mount $MOUNTPOINT
		wait_for_export
		parent=`rand_directory`
		file="`randstring $(( 1 + $RANDOM % $MAX_FILENAME_LEN ))`"
		$SUDO touch "$parent/$file"
	done
	randsleep
done
