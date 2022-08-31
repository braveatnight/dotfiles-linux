#!/usr/bin/env bash
NC='\033[0m' # No Color
# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

if (($EUID != 0)); then
  if [[ -t 1 ]]; then
    sudo "$0" "$@"
  else
    exec 1>output_file
    gksu "$0 $@"
  fi
  exit
fi
printf "${Purple} \nBeginning full system update...\n ${NC}"
echo
sleep 1
printf "${Red} \nUpdating flatpaks... ${NC}"
echo
sleep 1
flatpak update
sudo flatpak update
printf "${Cyan} \nUpdating AUR packages... ${NC}"
echo
sleep 1
aura -Akuax
printf "${Green} \nUpdating native packages...${NC}"
echo
sleep 1
sudo aura -Syu
printf "\nUpdate complete! Poggers!" | lolcat
