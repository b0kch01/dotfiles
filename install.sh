#!/bin/sh

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NORMAL='\e[0m'

color() {
  echo -e "$1$2${NORMAL}"
}

# Making sure .config exists
if [ -f ".config" ]; then
  color $GREEN "Found .config"
else
  color $YELLOW ".config does not exist. Creating one for you."
  touch .config
  echo
  echo "[ TIPS ]"
  echo " o Enter which directories/files to sync, seperated by new lines."
  echo " o Re-run this install.sh script."

  exit 0
fi


### NORMAL PROGRAM EXECUTION

pull_and_sync() {
  echo
  color $BLUE "Pulling latest changes"
  git pull origin main

  if [ "$?" -ne "0" ]; then
    color $RED "[FAIL] Could not pull latest changes."
    exit 1
  fi
}

sync_and_push() {
  echo "Pushing!"
}

echo
echo What would you like to do?
echo
echo [1] Pull and sync from remote
echo [2] Push and sync to remote

read -p "> " MENU_CHOICE

if [ "$MENU_CHOICE" -eq "1" ]; then
  pull_and_sync
elif [ "$MENU_CHOICE" -eq "2" ]; then
  sync_and_push
else
  exit 0
fi
