#!/bin/bash

set -e

bloxbatch -interactive -noPrompt << EOF
open workspace
transaction
exec <doc>
+clear[] = currentTurn[].
</doc>
commit
transaction
exec <doc>
+validate[] = currentTurn[].
</doc>
commit
echo "If turn is invalid, here are the reasons:"
query invalidTurnReasons
EOF

exit 0