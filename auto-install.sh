#!/bin/bash

SCRIPT_SRC_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}"   )" >/dev/null 2>&1 && pwd   )"

echo "Auto installing pubenvconfig"

cd $SCRIPT_SRC_DIR

cp scripts/cart* scripts/git-* ~/.local/bin/

cp -r .config ~

cp .tmux.conf ~

cp .vimrc ~

cp -r .vifm ~

echo "Automatic install finished."

echo "Now, run less ${SCRIPT_SRC_DIR}/README.md to see manual instructions."

echo "Also look at ${SCRIPT_SRC_DIR}/.bashrc to patch ~/.bashrc"
