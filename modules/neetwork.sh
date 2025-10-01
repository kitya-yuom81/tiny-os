mod_network(){
clear; banner "Network"; hr
if is_cmd ip; then ip -4 a | awk '/inet /{print $2,$7}'; else ifconfig | awk '/inet /{print $2,$1}'; fi
echo; cat <<'NM'
[1] Ping host [2] Open TCP ports [3] Quick speed test [b] Back
NM
prompt "Choose" n
case ${n:-} in
1) prompt "Host/IP" h; ping -c 4 "$h" || true; pause ;;
2) info "Listening TCP (root may show more)"; (ss -tulpn 2>/dev/null || lsof -iTCP -sTCP:LISTEN -n -P 2>/dev/null || netstat -tulpn 2>/dev/null) | head -n 50; pause ;;
3) if is_cmd speedtest; then speedtest; else warn "Install 'speedtest' to use this."; fi; pause ;;
*) ;;
esac
}