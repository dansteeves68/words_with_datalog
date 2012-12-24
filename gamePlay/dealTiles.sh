#!/bin/bash

set -e

players="1 2"
quantity="1"

function usage {
    echo "Usage: dealTiles.sh [-p player] [-q quantity]"
    echo "       default deals 1 tile to each to both players"
}

while getopts "p:q:h" optionName; do
    case "$optionName" in
        p) players="$OPTARG";;
        q) quantity="$OPTARG";;
        h) usage; exit 0;;
    esac
done

for player in ${players}
do
    for t in $(seq 1 ${quantity})
    do
        bloxbatch -interactive -noPrompt << EOF
open workspace
transaction
exec <doc>
+deal[] = ${player}.
</doc>
commit
close
exit
EOF
    done
    echo "Player ${player}:"
    bloxbatch -interactive -noPrompt << EOF
open workspace
query <doc>
_[] = foo <- foo = showHand[${player}].
</doc>
EOF
done

for player in ${players}
do
    echo "Dealt ${quantity} tiles to player ${player}"
done

exit 0