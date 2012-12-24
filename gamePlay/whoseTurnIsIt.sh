#!/bin/bash

set -e

bloxbatch -interactive -noPrompt << EOF
open workspace
query <doc>
_[] = str
<-
str = "Player " + p_str + "'s move. Turn is #" + t_str,
turn:player[t] = p,
p_str = uint32:string:convert[p],
t_str = uint32:string:convert[t],
t = currentTurn[].
</doc>
close
exit

exit 0