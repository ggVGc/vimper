#!/usr/bin/env bash


scriptRoot="./reaper-vim/"


keymapFile="keys.ReaperKeyMap"

rm -r mapper_scripts
mkdir mapper_scripts

rm -r build
mkdir build

tmpScripts="build/scripts"
tmpKeys="build/keys"

function gen() {
  local c
  local out
  local keycode
  # local shiftCode
  c="$1"
  out="$2"
  keycode="$3"
  shiftCode="$4"
  f="mapper_scripts/mapper_$c.lua"
  cp char_template.lua "$f"
  echo "doInput('$out')" >> "$f"

  id="vimper_$c"
  desc="[vimper] $c"
  printf "SCR 4 0 \"%s\" \"%s\" %s%s\n" "$id" "$desc" "$scriptRoot" "$f" >> "$tmpScripts"
  if [[ "$shiftCode" != "" ]]; then
    printf "KEY 5 %s %s 0\n" "$keycode" "_$id" >> "$tmpKeys"
    printf "KEY 1 %s %s 0\n" "$shiftCode" "$id" >> "$keymapFile"
  else
    printf "KEY 1 %s %s 0\n" "$keycode" "_$id" >> "$tmpKeys"
  fi
}

numbers="0123456789"
letters="abcdefghijklmnopqrstuvwxyz"

for (( i=0; i<${#numbers};i++ )) ; do
  c="${numbers:$i:1}"
  gen "$c" "$c" $(( 48 + i ))
done

for (( i=0; i<${#letters};i++ )) ; do
  c="${letters:$i:1}"
  upper=$(echo "$c" | tr '[:lower:]' '[:upper:]')
  gen $c $c $(( 65 + i ))
  gen "big_$c" "$upper" $(( 65 + i )) $(( 41 + i ))
done

gen "esc" "<esc>" 27
gen "space" "<space>" 32

cat "$tmpScripts" "$tmpKeys" > "$keymapFile"

