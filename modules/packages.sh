mod_packages(){
clear; banner "Packages"; hr
PM=$(pm_detect)
if [[ -z $PM ]]; then err "No package manager detected"; pause; return; fi
print_kv "Package mgr" "$PM"
echo; cat <<'PM'
[1] List installed [2] Update indexes [3] Upgrade all [b] Back
PM
prompt "Choose" a
case ${a:-} in
1)
case $PM in
apt) dpkg -l | awk 'NR>5{print $2" " $3}' | head -n 100 ;;
dnf|yum) rpm -qa | head -n 100 ;;
pacman) pacman -Q | head -n 100 ;;
zypper) zypper se -i | head -n 100 ;;
brew) brew list --versions | head -n 100 ;;
esac; pause ;;
2)
case $PM in
apt) require_sudo && sudo apt update ;;
dnf) require_sudo && sudo dnf check-update || true ;;
yum) require_sudo && sudo yum check-update || true ;;
pacman) require_sudo && sudo pacman -Sy ;;
zypper) require_sudo && sudo zypper refresh ;;
brew) brew update ;;
esac; pause ;;
3)
case $PM in
apt) require_sudo && sudo apt upgrade -y ;;
dnf) require_sudo && sudo dnf upgrade -y ;;
yum) require_sudo && sudo yum update -y ;;
pacman) require_sudo && sudo pacman -Su --noconfirm ;;
zypper) require_sudo && sudo zypper update -y ;;
brew) brew upgrade ;;
esac; pause ;;
*) ;;
esac
}