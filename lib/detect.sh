#!/usr/bin/env bash
OS="$(uname -s)"; KERNEL="$(uname -r)"
PM=""; SERVICE_MGR=""


os_summary(){ printf "%s %s (%s)\n" "${OS}" "${KERNEL}" "$(hostname)"; }


pm_detect(){
for c in apt dnf yum pacman zypper brew; do
if command -v "$c" >/dev/null 2>&1; then PM=$c; break; fi
done
echo -n "$PM"
}


service_detect(){
if command -v systemctl >/dev/null 2>&1; then SERVICE_MGR=systemctl
elif [[ ${OS} == "Darwin" ]] && command -v launchctl >/dev/null 2>&1; then SERVICE_MGR=launchctl
elif command -v service >/dev/null 2>&1; then SERVICE_MGR=service
else SERVICE_MGR=""; fi
echo -n "$SERVICE_MGR"
}