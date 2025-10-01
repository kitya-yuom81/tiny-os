mod_users(){
clear; banner "Users"; hr
echo "Logged-in:"; who || true
echo; echo "Last logins:"; last -n 10 2>/dev/null || echo "(no 'last' on this OS)"
echo; cat <<'UM'
[1] List users [2] Create user (Linux) [b] Back
UM
prompt "Choose" u
case ${u:-} in
1) cut -d: -f1 /etc/passwd 2>/dev/null | head -n 50 || dscl . list /Users; pause ;;
2) if [[ $(uname -s) == Linux ]]; then prompt "Username" nu; warn "Will create user '$nu'"; if confirm; then require_sudo && sudo useradd -m "$nu" && info "Created" || err "Failed"; fi; else warn "Not supported on macOS"; fi; pause ;;
*) ;;
esac
}