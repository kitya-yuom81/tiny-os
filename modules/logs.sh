mod_logs(){
clear; banner "Logs"; hr
if is_cmd journalctl; then
echo "Showing latest 200 lines (journalctl):"; sudo journalctl -n 200 -xe --no-pager || true
elif [[ -f /var/log/syslog ]]; then tail -n 200 /var/log/syslog
elif [[ -f /var/log/system.log ]]; then tail -n 200 /var/log/system.log
else warn "No common log source found"; fi
pause
}