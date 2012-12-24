#!/bin/bash

set -e

players="1 2"

function usage {
    echo "Usage: showHand.sh [-p player]"
    echo "       default shows both players hands"
}

while getopts "p:q:h" optionName; do
    case "$optionName" in
        p) players="$OPTARG";;
        h) usage; exit 0;;
    esac
done

for player in ${players}
do
    echo "Player ${player}:"
    bloxbatch -interactive -noPrompt << EOF
open workspace
query <doc>
_[] = foo <- foo = showHand[${player}].
</doc>
EOF
done

exit 0