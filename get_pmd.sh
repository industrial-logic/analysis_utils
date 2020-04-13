#!/bin/bash

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

function latest_pmd {
	curl  --silent https://github.com/pmd/pmd/releases/latest | sed "s/.*https/https/" | sed "s/tag/download/" | sed 's/\([0-9.]*\)".*/\1\/pmd-bin-\1.zip/'
}

function pmd_run() {
  echo "${SCRIPT_DIR}"/pmd-bin-*/bin/run.sh
}

PMD_DIR=$(find "$SCRIPT_DIR" -maxdepth 1 -type d -name "pmd*")
if [ -z "$PMD_DIR" ]; then
	pushd "$SCRIPT_DIR" > /dev/null || exit
	curl --silent -L -O "$(latest_pmd)"
	unzip -qq pmd*.zip 
	rm pmd*.zip
	popd > /dev/null || exit
fi
