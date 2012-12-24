#!/bin/bash

set -e

if [ -d workspace ]; then
    rm -rf workspace
fi

pushd ../

bloxbatch -interactive -noPrompt < wordsWithLogicBlox.lb

cp -r workspace gamePlay/

popd

echo "New board set up, ready to deal tiles"

exit 0