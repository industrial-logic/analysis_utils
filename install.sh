#!/bin/bash

# shellcheck source=.

DEST=.analysis_utils

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
CURRENT=`PWD`

function git_or_go() {
    if [[ ! -d ".git" ]]; then
	echo "This does not appear to be a git repository" 1>&2
	exit 1
    fi
}

function install_tool() {
    if [[ -d "$DEST" ]];
    then
        pushd "$DEST"
        git pull
        popd
    else
        git clone https://github.com/schuchert/analysis_utils.git "$DEST"
    fi

    if [[ ! $(grep "$DEST" build.gradle) ]]; then
	echo "$DEST" >> .gitignore
	git add .gitignore
        git commit -m 'Updated to skip eCoach tool'
    fi
}

function update_commit_gradle() {
    if [[ ! $(grep "checkDuplication" build.gradle) ]]; then
        sed "s/XXX/$DEST/" \
		$SCRIPT_DIR/install_support/gradle/eCoach.gradle \
		>> build.gradle
        git add build.gradle
        git commit -am 'Adding support for eCoach'
    fi
}

function install_git_hook() {
    if [[ -f ".git/hooks/post-commit" ]]; then
        echo "Already installed or existing post-commit hook" 1>&2
    else
        sed "s/XXX/$DEST/" \
		$SCRIPT_DIR/install_support/hooks/post-commit \
		> .git/hooks/post-commit
    fi
}

git_or_go
install_tool
update_commit_gradle
install_git_hook
