function step() {
    echo -e "\n[Step] $1"
}

function fail_exit() {
    echo "[✗] $1"
    exit 1
}
