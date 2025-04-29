# Read standard input into variable 'text' until the first '%' character is encountered
IFS='%' read -r -d '%' text