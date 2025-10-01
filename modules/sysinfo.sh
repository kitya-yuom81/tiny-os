mod_sysinfo(){
clear; banner "System Info"; hr
print_kv "Hostname" "$(hostname)"
print_kv "OS" "$(uname -s)"
print_kv "Kernel" "$(uname -r)"
print_kv "Uptime" "$(uptime | sed 's/.*up //; s/,\s*\([0-9]\+ users\).*/ \1/;')"
if is_cmd lscpu; then CPU=$(lscpu | awk -F: '/Model name/ {gsub(/^ +/,"",$2); print $2; exit}'); else CPU=$(sysctl -n machdep.cpu.brand_string 2>/dev/null || echo "n/a"); fi
print_kv "CPU" "${CPU:-n/a}"
if is_cmd free; then MEM=$(free -h | awk '/Mem:/ {print $3"/"$2}'); else MEM=$(vm_stat 2>/dev/null | awk '/Pages (free|active|inactive|speculative)/ {sum+=$3} END{printf "%.1f/%.1f GiB", (sum*4096)/1024/1024/1024, (sysctl -n hw.memsize)/1024/1024/1024}' 2>/dev/null || echo n/a); fi
print_kv "Memory" "${MEM:-n/a}"
echo; hr; pause
}