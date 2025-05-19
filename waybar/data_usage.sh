#!/bin/bash

TODAY=$(vnstat -i wlp4s0 --oneline | cut -d\; -f6)

MONTH=$(vnstat -i wlp4s0 --oneline | cut -d\; -f11)

echo "Today: $TODAY | Month: $MONTH"
