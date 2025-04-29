#!/bin/bash
git checkout develop
git pull origin develop --no-rebase --strategy=recursive --strategy-option=ours