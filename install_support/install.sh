#!/bin/bash

# shellcheck source=.

DEST=../analysis_utils

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
}

function update_commit_gradle() {
    if [[ ! $(grep "eCoach[.]gradle" build.gradle) ]]; then
        if [[ ! -z "$(tail -c 1 build.gradle)" ]]; then
            echo "" >> build.gradle
        fi
        cat $SCRIPT_DIR/gradle/eCoach_stub >> build.gradle
        git add build.gradle
        git commit -am 'Adding support for eCoach'
    fi
}

git_or_go
install_tool
update_commit_gradle
