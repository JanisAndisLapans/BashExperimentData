#!/bin/bash

mkdir -p /etc/movedDocs

find /etc/docs -name "*.docx.found" -exec sh -c 'mv "$0" /etc/movedDocs/ && mv "${0%.found}" /etc/movedDocs/' {} \;