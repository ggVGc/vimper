#!/usr/bin/env bash


scriptRoot="./reaper-vim/"


keymapFile="keys.ReaperKeyMap"

rm -r mapper_scripts
mkdir mapper_scripts

rm -r build
mkdir build

tmpScripts="build/scripts"
tmpKeys="build/keys"


function genScript() {
  local id desc file
  id="$1"
  desc="$2"
  file="$3"
  printf "SCR 4 0 \"%s\" \"%s\" %s%s\n" "$id" "$desc" "$scriptRoot" "$file" >> "$tmpScripts"
}

function genKey() {
  local keyType keyCode target
  keyType="$1"
  keyCode="$2"
  target="$3"
  printf "KEY %s %s %s 0\n" "$keyType" "$keyCode" "$target"
}


function gen() {
  local c out keyCode keyType extraInput
  c="$1"
  out="$2"
  keyCode="$3"
  keyType="$4"
  extraInput="$5"
  if [[ "$keyType" == "" ]]; then
    keyType=1
  fi
  f="mapper_scripts/mapper_$c.lua"
  cp char_template.lua "$f"
  echo "reaper.Undo_OnStateChange('');" >> "$f"
  if [[ "$extraInput" != "" ]]; then
    echo "doInput('$extraInput')" >> "$f"
  fi
  echo "doInput('$out')" >> "$f"

  id="vimper_$c"
  desc="[vimper] $c"
  genScript "$id" "$desc" "$f"
  genKey "$keyType" "$keyCode" "_$id">> "$tmpKeys"
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
  n=$(( 65 + i ))
  gen $c $c $(( 65 + i ))
  gen "big_$c" "$upper" "$n" 5
  gen "ctrl_$c" "$c" "$n"  33 "<ctrl>"
  gen "alt_$c" "$c" "$n"  17 "<alt>"
done

gen "esc" "<esc>" 27
gen "space" "<space>" 32
gen "period" "." 46 0

cat "$tmpScripts" "$tmpKeys" > "$keymapFile"

