#!/bin/bash

tr -dc '01' < /dev/urandom | head -c 75; echo