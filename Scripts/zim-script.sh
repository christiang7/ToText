#!/bin/bash
output="$(eval $@ 2>&1)"
yad --timeout=15 --timeout-indicator=top --form --separator="~" --item-separator="," \
	--field="Output Script:":TXT \
	"$output" --mouse
