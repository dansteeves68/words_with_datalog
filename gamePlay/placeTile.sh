#!/bin/bash

set -e

function usage {
    echo "Usage: placeTile.sh -t tile -x column -y row"
    echo "       place tile from hand to board for current turn"
}

while getopts "t:x:y:h" optionName; do
    case "$optionName" in
        t) tile="$OPTARG";;
        x) column="$OPTARG";;
        y) row="$OPTARG";;
        h) usage; exit 0;;
    esac
done

bloxbatch -interactive -noPrompt << EOF
open workspace
transaction
exec <doc>
+try(${tile}, space) <- space = space:coordinates[${column}, ${row}].
</doc>
commit
echo "     -7|-6|-5|-4|-3|-2|-1|  |1 |2 |3 |4 |5 |6 |7"
query showRow
echo
query <doc>
_[] = str
<-
str = "Player: " + player_str,
player_str = uint32:string:convert[player],
turn:player[turn] = player,
currentTurn[] = turn.
</doc>
query <doc>
_[] = showHand[player]
<-
turn:player[turn] = player,
currentTurn[] = turn.
</doc>
close
exit
EOF

exit 0