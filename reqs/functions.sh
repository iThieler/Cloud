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

function UpdateAndUpgrade() {
  # This function performs a complete system update of the server
  # ----------
  # Call with: updateAndUpgrade
  # ----------
  {
    echo -e "XXX\n12\n${lang_updateupgrade_execmessage}\nXXX"
    if ! apt update 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n35\n${lang_updateupgrade_execmessage}\nXXX"
    if ! apt upgrade -y 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n51\n${lang_updateupgrade_execmessage}\nXXX"
    if ! apt dist-upgrade -y 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n74\n${lang_updateupgrade_execmessage}\nXXX"
    if ! apt autoremove -y 2>&1 >/dev/null; then false; fi
    echo -e "XXX\n98\n${lang_updateupgrade_execmessage}\nXXX"
  } | whiptail --gauge --backtitle "${lang_backtitle}" --title " ${lang_updateupgrade_title} " "${lang_updateupgrade_mainmessage}" 10 80 0
  
  return 0
}

function checkIP() {
  # This function returns true if the given IP address is reachable, if not, you can check the IP address and change it if necessary.
  # ----------
  # Call with: checkIP "192.168.0.1"      !!! Note - 192.168.0.1 is the IP address to be checked in this example !!!
  # use in an if-query: if checkIP "192.168.0.1"; then ipExist=true; else ipExist=false; fi
  # use in an if-query: if checkIP "${IPVAR}"; then ipExist=true; else ipExist=false; fi
  # ----------
  function ping() { if ping -c 1 $1 &> /dev/null; then true; else false; fi }
  
  if [ -n $1 ]; then ip="$1"; else ip=""; fi
  
  while ! ping ${ip}; do
    ip=$(whip_alert_inputbox_cancel "${lang_okbutton}" "${lang_cancelbutton}" "${lang_checkip_title}" "${lang_checkip_mainmessage}" "${ip}")
    RET=$?
    if [ $RET -eq 1 ]; then return 1; fi  # Check if User selected cancel
  done
}

