#!/usr/bin/env bash

rm -r mapper_scripts
mkdir mapper_scripts

function gen() {
  local c
  local out
  c="$1"
  out="$2"
  f="mapper_scripts/mapper_$c.lua"
  cp char_template.lua "$f"
  echo "doInput('$out')" >> "$f"
}
letters="abcdefghijklmnopqrstuvwxyz"

str="0123456789$letters:;"
for (( i=0; i<${#str};i++ )) ; do
  c="${str:$i:1}"
  gen $c $c
done


for (( i=0; i<${#letters};i++ )) ; do
  c="${letters:$i:1}"
  upper=$(echo "$c" | tr '[:lower:]' '[:upper:]')
  gen "big_$c" "$upper"
done

gen "<esc>" "<esc>"
gen "<space>" "<space>"
