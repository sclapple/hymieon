#!/usr/bin/env bash
STATE_FILE="/tmp/noctalia-dpms-state"
if [ -f "$STATE_FILE" ]; then
	rm "$STATE_FILE"
	noctalia msg dpms-off
else
	touch "$STATE_FILE"
	noctalia msg dpms-on
fi