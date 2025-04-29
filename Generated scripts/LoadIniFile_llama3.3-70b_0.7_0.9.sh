#!/bin/bash

# Load settings from settings.ini into the current shell
while IFS="=" read -r key value; do
  declare "$key=$value"
done < <(grep -v '^#' settings.ini | grep -v '^$')