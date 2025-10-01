mod_services(){
clear; banner "Services"; hr
SVC=$(service_detect)
if [[ -z $SVC ]]; then warn "No service manager detected"; pause; return; fi
print_kv "Manager" "$SVC"
echo; cat <<'SV'
[1] Status of a service [2] Start [3] Stop [b] Back
SV
prompt "Service name" name
case ${SVC} in
systemctl)
prompt "Choose" c
case ${c:-} in
1) systemctl status "$name" --no-pager || true ;;
2) require_sudo && sudo systemctl start "$name" ;;
3) require_sudo && sudo systemctl stop "$name" ;;
esac ;;
launchctl)
prompt "Choose" c
case ${c:-} in
1) launchctl print system/"$name" || launchctl list | grep "$name" || true ;;
2) sudo launchctl load -w "/Library/LaunchDaemons/$name.plist" || true ;;
3) sudo launchctl unload -w "/Library/LaunchDaemons/$name.plist" || true ;;
esac ;;
service)
prompt "Choose" c
case ${c:-} in
1) service "$name" status || true ;;
2) require_sudo && sudo service "$name" start ;;
3) require_sudo && sudo service "$name" stop ;;
esac ;;
esac
pause
}