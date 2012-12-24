#!/bin/bash

set -e

bloxbatch -interactive -noPrompt << EOF
open workspace
transaction
exec <doc>
+clear[] = turn <- turn = currentTurn[].
</doc>
commit
transaction
exec <doc>
+validate[] = turn <- turn = currentTurn[].
</doc>
commit
transaction
exec <doc>
+turn(turn),
+turn:player[turn] = next_player,
^currentTurn[] = turn
<-
turn:player@prev[last_turn] = last_player,
(
 (next_player = 1, last_player = 2)
 ;
 (next_player = 2, last_player = 1)
),
currentTurn@prev[] = last_turn,
!invalidTurn@prev(last_turn).
</doc>
commit
EOF

exit 0