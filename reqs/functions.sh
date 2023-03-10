#!/bin/bash

function headLOGO() {
  # This function clears the shell prompt and displays the logo with the selected message
  # ----------
  # Call with: headLOGO "MESSAGE"       !!! Note - Maximum 35 characters !!!
  # ----------
  clear
  echo -e "
   _ _____ _    _     _         _    
  (_)_   _| |_ (_)___| |___ _ _( )___
  | | | | | ' \| / -_) / -_) '_|/(_-<
  |_| |_| |_||_|_\___|_\___|_|   /__/
  "${1}"                                          
"
}

function generatePassword() {
  # This function generates a random secure password
  # ----------
  # Call with: generatePassword 12      !!! Note - 12 is the password length in this example !!!
  # ----------
  chars=({0..9} {a..z} {A..Z} "_" "%" "+" "-" ".")
  for i in $(eval echo "{1..$1}"); do
    echo -n "${chars[$(($RANDOM % ${#chars[@]}))]}"
  done 
}

function generateAPIKey() {
  # This function generates a random API-Key
  # ----------
  # Call with: generateAPIKey 32      !!! Note - 32 is the length of the API key in this example !!!
  # ----------
  chars=({0..9} {a..f})
  for i in $(eval echo "{1..$1}"); do
    echo -n "${chars[$(($RANDOM % ${#chars[@]}))]}"
  done 
}

function updateAndUpgrade() {
  # This function performs a complete system update of the server
  # ----------
  # Call with: updateAndUpgrade
  # ----------
  {
    echo -e "XXX\n12\nSystemupdate wird ausgeführt ...\nXXX"
    if ! apt-get update 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n25\nSystemupdate wird ausgeführt ...\nXXX"
    if ! apt-get upgrade -y 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n47\nSystemupdate wird ausgeführt ...\nXXX"
    if ! apt-get dist-upgrade -y 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n64\nSystemupdate wird ausgeführt ...\nXXX"
    if ! apt-get autoremove -y 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n79\nSystemupdate wird ausgeführt ...\nXXX"
    if ! pveam update 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n98\nSystemupdate wird ausgeführt ...\nXXX"
  } | whiptail --gauge --backtitle "© 2021 - iThieler's Proxmox Script collection" --title " SYSTEMVORBEREITUNG " "Dein HomeServer wird auf Systemupdates geprüft ..." 10 80 0

  # install DarkMode
  if ! bash <(curl -s https://raw.githubusercontent.com/Weilbyte/PVEDiscordDark/master/PVEDiscordDark.sh) install 2>&1 >/dev/null; then false; fi
  
  return 0
}
