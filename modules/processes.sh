mod_processes(){
clear; banner "Processes"; hr
echo "Top CPU:"; ps aux | sort -rk 3,3 | head -n 10 | awk '{printf "%6s %5s %4s %s\n", $2,$3,$4,$11}'
echo; echo "Top MEM:"; ps aux | sort -rk 4,4 | head -n 10 | awk '{printf "%6s %5s %4s %s\n", $2,$3,$4,$11}'
echo; cat <<'PMENU'
[1] Search by name [2] Kill by PID [b] Back
PMENU
prompt "Choose" p
case ${p:-} in
1) prompt "Name contains" q; ps aux | grep -i -- "$q" | grep -v grep | awk '{printf "%6s %5s %4s %s\n", $2,$3,$4,$11}'; pause ;;
2) prompt "PID to kill" k; warn "About to kill PID $k"; if confirm; then kill "$k" && info "Killed $k" || err "Failed"; fi; pause ;;
*) ;;
esac
}