factorial() {
    n=$1
    result=1
    for (( i=2; i<=n; i++ )); do
        result=$((result * i))
    done
    echo $result
}

factorial 623