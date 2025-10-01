is_cmd(){ command -v "$1" >/dev/null 2>&1; }
need_cmd(){ is_cmd "$1" || { err "Missing required command: $1"; exit 1; }; }
require_sudo(){ if [[ $(id -u) -ne 0 ]]; then sudo -v || { err "sudo required"; return 1; } fi; }
confirm(){ read -rp "Type 'yes' to continue: " ans; [[ ${ans:-} == "yes" ]]; }
print_kv(){ printf "%-16s %s\n" "$1" "$2"; }
hr(){ printf -- '%.0s─' {1..50}; echo; }
now(){ date '+%Y-%m-%d %H:%M:%S'; }