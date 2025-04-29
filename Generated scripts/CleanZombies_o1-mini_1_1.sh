#!/bin/bash
ps -eo ppid,state | awk '$2 == "Z" {print $1}' | sort -u | xargs kill -9