mod_storage(){
clear; banner "Storage"; hr
echo "Disks:"; df -h | awk 'NR==1 || /\/$/ {print}'
echo; cat <<'SM'
[1] Largest items under a path [2] Largest files under a path [b] Back
SM
prompt "Choose" s
case ${s:-} in
1) prompt "Path" p; du -sh "$p"/* 2>/dev/null | sort -hr | head -n 20; pause ;;
2) prompt "Path" p;
# Cross-platform: GNU stat (-c) on Linux, BSD stat (-f) on macOS
if stat -c "%s %n" /bin/sh >/dev/null 2>&1; then
find "$p" -type f -exec stat -c '%s %n' {} + 2>/dev/null
else
find "$p" -type f -exec stat -f '%z %N' {} + 2>/dev/null
fi | sort -nr | head -n 20 | awk '{printf "%.1f MB ", $1/1024/1024; $1=""; print substr($0,2)}';
pause ;;
*) ;;
esac
}