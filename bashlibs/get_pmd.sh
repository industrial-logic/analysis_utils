#!/bin/bash

script_dir=$1

function latest_pmd {
	curl  --silent https://github.com/pmd/pmd/releases/latest | sed "s/.*https/https/" | sed "s/tag/download/" | sed 's/\([0-9.]*\)".*/\1\/pmd-bin-\1.zip/'
}

function pmd_run() {
  echo "${script_dir}"/pmd-bin-*/bin/run.sh
}

PMD_DIR=$(find "$script_dir" -maxdepth 1 -type d -name "pmd*")
if [ -z "$PMD_DIR" ]; then
	pushd "$script_dir" > /dev/null || exit
	curl --silent -L -O "$(latest_pmd)"
	unzip -qq pmd*.zip 
	rm pmd*.zip
	popd > /dev/null || exit
fi
