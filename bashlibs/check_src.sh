#!/bin/bash

function check_src_dir() {
    if [[ ! $(find . -type d -name src) ]]; then
		echo "There doesn't seem to be a ./src directory."
		echo "Did you run this script in a maven/gradle based Java project?"
		exit 1
	fi
}
