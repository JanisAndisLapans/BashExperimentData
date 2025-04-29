#!/bin/bash

factorial() {
  local num=$1
  local result=1
  for ((i=2; i<=num; i++)); do
    result=$((result * i))
  done
  echo "$result"
}

factorial 623