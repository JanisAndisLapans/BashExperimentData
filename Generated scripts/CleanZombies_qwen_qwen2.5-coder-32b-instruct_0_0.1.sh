#!/bin/bash
ps -eo pid,ppid,state,cmd | awk '$3 == "Z" {print $2}' | xargs -I {} kill -9 {}