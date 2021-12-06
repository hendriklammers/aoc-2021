#!/usr/bin/env bash

DAY="${1}"
AOC_SESSION_COOKIE=""

curl "https://adventofcode.com/2021/day/${DAY}/input" -H "cookie: session=${AOC_SESSION_COOKIE}" -o "day_${DAY}.txt" 2>/dev/null

touch "day_${DAY}.lua"
