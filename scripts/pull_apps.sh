#!/bin/bash
while read -r line; do
	apt-get install $line
done <  "$1"

