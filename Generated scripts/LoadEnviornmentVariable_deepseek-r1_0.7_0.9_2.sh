USERNAME=$(grep -E '^USERNAME=' .env | sed -e 's/^USERNAME=//' -e 's/^["'\''"]//' -e 's/["'\''"]$//')
export USERNAME