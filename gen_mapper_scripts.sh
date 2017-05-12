#!/usr/bin/env bash


scriptRoot="./vimper/"


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
  contextID="$4"
  printf "SCR 4 $contextID \"%s\" \"%s\" %s%s\n" "$id" "$desc" "$scriptRoot" "$file" >> "$tmpScripts"
}

function genKey() {
  local keyType keyCode target contextID
  keyType="$1"
  keyCode="$2"
  target="$3"
  contextID="$4"
  printf "KEY %s %s %s %s\n" "$keyType" "$keyCode" "$target" "$contextID"
}


function genContext() {
  local contextName
  tmpFile="$1"
  context="$2"
  contextID="$3"
  c="$4"
  out="$5"
  keyCode="$6"
  keyType="$7"
  extraInput="$8"

  f="mapper_scripts/_$c$context.lua"
  cp char_template.lua "$f"
  echo "reaper.Undo_OnStateChange('');" >> "$f"
  # echo "reaper.defer(function()" >> "$f"
  if [[ "$extraInput" != "" ]]; then
    echo "doInput('$extraInput', '$context')" >> "$f"
  fi
  echo "doInput('$out', '$context')" >> "$f"
  # echo "end)" >> "$f"


  id="vimper_$c$context"
  desc="Script: [vimper] [$context] $c"
  genScript "$id" "$desc" "$f" "$contextID"
  genKey "$keyType" "$keyCode" "_$id" "$contextID" >> "$tmpFile"
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

  genContext  "$tmpKeys" "main" 0 "$c" "$out" "$keyCode" "$keyType" "$extraInput"
  genContext "$tmpKeys" "midi" 32060 "$c" "$out" "$keyCode" "$keyType" "$extraInput"
}

numbers="0123456789"
letters="abcdefghijklmnopqrstuvwxyz"

for (( i=0; i<${#numbers};i++ )) ; do
  c="${numbers:$i:1}"
  gen "$c" "$c" $(( 48 + i ))
  gen "num_$c" "<num$c>" $(( 96 + i ))
  gen "alt_num_$c" "<num$c>" $(( 96 + i )) 17 "<alt>"
  gen "ctrl_num_$c" "<num$c>" $(( 96 + i )) 33 "<ctrl>"
done

for (( i=0; i<${#letters};i++ )) ; do
  c="${letters:$i:1}"
  upper=$(echo "$c" | tr '[:lower:]' '[:upper:]')
  n=$(( 65 + i ))
  gen $c $c $(( 65 + i ))
  gen "big_$c" "$upper" "$n" 5
  gen "ctrl_big_$c" "$upper" "$n" 37 "<ctrl>"
  gen "alt_big_$c" "$upper" "$n" 21 "<alt>"
  gen "ctrl_$c" "$c" "$n"  33 "<ctrl>"
  gen "mod_$c" "$c" "$n"  9 "<mod>"
  gen "alt_$c" "$c" "$n"  17 "<alt>"
done

gen "esc" "<esc>" 27
gen "space" "<space>" 32
gen "period" "." 46 0
gen "left_shift" "<" 60 0
gen "right_shift" ">" 62 0
gen "colon" ":" 58 0
gen "cr" "<cr>" 13
gen "tab" "<tab>" 9
gen "backspace" "<bs>" 8
gen "comma" "," 44 0
gen "hyphen" "-"  45 0
gen "underscore" "_" 95 0
gen "semicolon" ";" 59 0 
gen "questionmark" "?"  63 0
gen "plus" "+" 43 0
gen "backslash" "\\\\" 92 0
gen "slash" "/" 47 0
gen "numbersign" "#" 35 0
gen "at" "@" 64 0
gen "sectionsign" "§" 167 0
gen "tilde" "~" 126 0
gen "plusminus" "±" 177 0
gen "closebracket" "]" 93 0
gen "openbracket" "[" 91 0
gen "closewing" "}" 125 0
gen "openwing" "{" 123 0
gen "pipe" "|" 124 0
gen "equals" "=" 61 0
gen "backtick" "\`" 96 0



cat "$tmpScripts" "$tmpKeys" > "$keymapFile"

