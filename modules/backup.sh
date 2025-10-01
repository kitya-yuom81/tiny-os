mod_backup(){
clear; banner "Backup"; hr
prompt "Folder to backup" src
[[ -d $src ]] || { err "Not a folder"; pause; return; }
prompt "Exclude pattern (optional, e.g. node_modules)" ex
out="$(basename "$src")_$(date +%Y%m%d_%H%M%S).tar.gz"
warn "Will create $out in current dir"
if confirm; then
if [[ -n ${ex:-} ]]; then tar --exclude="$ex" -czf "$out" -C "$(dirname "$src")" "$(basename "$src")"; else tar -czf "$out" -C "$(dirname "$src")" "$(basename "$src")"; fi
info "Backup created: $out"
fi
pause
}