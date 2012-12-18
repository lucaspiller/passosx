#!/bin/bash
PASSWORD_LENGTH=16
URL_SCRIPT="$(dirname $0)/ChromeUrl.AppleScript"

domain="$(osascript "$URL_SCRIPT" | awk -F/ '{print $3}')"
if [[ $domain == "" ]]; then
  exit 1
fi

name="Sites/$domain"

pass -c $name
if [[ $? -eq 1 ]]; then
  echo -n "Generate a password for $domain? (Y/n) "

  read generate
  if [[ $generate == "n" ]]; then
    exit 1
  fi

  echo "Generating..."
  pass generate -c $name $PASSWORD_LENGTH
fi
