#!/bin/bash

set -e

echo "     -7|-6|-5|-4|-3|-2|-1|  |1 |2 |3 |4 |5 |6 |7"
bloxbatch -db workspace -query showRow
echo

exit 0