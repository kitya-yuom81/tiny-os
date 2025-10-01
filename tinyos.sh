#!/usr/bin/env bash
set -euo pipefail


# shellcheck source=lib/colors.sh
source "$(dirname "$0")/lib/colors.sh"
# shellcheck source=lib/utils.sh
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/detect.sh"
source "$(dirname "$0")/lib/checks.sh"


for m in sysinfo processes network storage users packages services logs backup; do
source "$(dirname "$0")/modules/${m}.sh"
done


main_menu() {
clear
banner "tinyos — Bash OS Control Center"
echo -e "${B}$(os_summary)${R}\n"
cat <<'MENU'
[1] System Info [2] Processes [3] Network
[4] Storage [5] Users [6] Packages
[7] Services [8] Logs [9] Backup
[q] Quit
MENU
prompt "Select option" choice
case ${choice:-} in
1) mod_sysinfo ;; 2) mod_processes ;; 3) mod_network ;;
4) mod_storage ;; 5) mod_users ;; 6) mod_packages ;;
7) mod_services ;; 8) mod_logs ;; 9) mod_backup ;;
q|Q) goodbye ;;
*) warn "Invalid choice"; pause ;;
esac
}


checks_run
while true; do main_menu; done