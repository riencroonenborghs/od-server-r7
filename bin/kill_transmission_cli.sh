#!/bin/bash

SCRIPT=$1

echo "kill \`ps a | grep transmission-cli | grep $SCRIPT | awk {'print \$1'}\`; rm -rf \"\$0\"" > $SCRIPT
chmod +x $SCRIPT