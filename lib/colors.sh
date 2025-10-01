R='\e[0m'; B='\e[1m'
RED='\e[31m'; GRN='\e[32m'; YEL='\e[33m'; BLU='\e[34m'; CYN='\e[36m'
info(){ echo -e "${GRN}✓${R} $*"; }
warn(){ echo -e "${YEL}!${R} $*"; }
err(){ echo -e "${RED}✗${R} $*" 1>&2; }
banner(){ echo -e "${BLU}${B}$*${R}"; }
prompt(){ local msg=$1; local __var=$2; read -rp "${CYN}?${R} ${msg}: " "$__var"; }
pause(){ read -rp "Press Enter to continue..." _; }
goodbye(){ info "Bye!"; exit 0; }