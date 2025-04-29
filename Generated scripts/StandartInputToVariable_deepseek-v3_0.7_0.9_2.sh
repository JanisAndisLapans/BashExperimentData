#!/bin/bash
# Read standard input into variable 'text' until the first '%' character is encountered
IFS='%' read -r -d '%' text

# Demonstrate usage of the variable (replace with your actual logic)
printf "Captured text: %s\n" "$text"
#!/bin/bash
# shellcheck disable=SC2034
IFS='%' read -r -d '%' text