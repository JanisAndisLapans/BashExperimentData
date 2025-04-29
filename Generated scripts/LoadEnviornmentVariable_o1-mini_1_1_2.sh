#!/bin/bash
USERNAME=$(grep '^USERNAME=' .env | cut -d '=' -f2-)
export USERNAME