#!/bin/bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RC="$DIR/runner.toml"

if [[ ! -f "$RC" ]] then
  >&2 echo "Config file 'runner.toml' not found at '$RC'"
  exit 1
fi

if [ $# -eq 0 ]
then
  echo -en "\0prompt\x1fRunner\n"
  toml get "$RC" . | jq "keys_unsorted | map(select(startswith(\"_\") | not))[]" -r
else
  rc_entry="$(toml get "$RC" $1)"
  # prompt="$(echo "$rc_entry" | jq)"
  # prompt="$(toml get "$RC" $1)"
  toml get "$RC" $1 | jq '.["_title"]' -r | awk '{print "\0prompt\x1f" $0}'
  >&2 echo Title: $(toml get "$RC" $1 | jq '.["_title"]' -r)
  >&2 echo Query: $1
  # toml get "$RC" $1 | jq "keys_unsorted | map(\"$1.\" + select(startswith(\"_\") | not))[]" -r
  >&2 echo 'toml get "$RC" $1 | jq "to_entries | map(select(.key | startswith(\"_\") | not)) | map(.key + (\"\0message\x1f\" | @text) + .value[\"_title\"])"[] -r'
  toml get "$RC" $1 | jq "to_entries | map(select(.key | startswith(\"_\") | not)) | map(.key + (\"\\u0000message\u001f\" | @text) + .value[\"_title\"])"[] -r
  toml get "$RC" $1 | jq "to_entries | map(select(.key | startswith(\"_\") | not)) | map(.value[\"_title\"] + (\"\\u0000message\u001f\" | @text) + .key)"[] -r
  # >&2 echo "args=$*"
  # local query=$(IFS="." echo "$*")
  # executor "$query"
  # executor "$(IFS="." echo "$*")"
  # executor $1
fi


