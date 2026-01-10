#!/bin/sh

RED='\e[31m'
GREEN='\e[32m'
YELLOW='\e[33m'
BLUE='\e[34m'
NORMAL='\e[0m'

color() {
  printf "$1$2${NORMAL}\n"
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

exists() {
  [ -d "$1" ] || [ -f "$1" ]
}

relativize() {
  local __out="$1"
  local path="$2"
  printf -v "$__out" '%s' "${path/#$HOME/~}"
}

preview_changes() {
  source_f="$1"
  source_d="$2"
  dest_f="$3"
  dest_d="$4"

  while read -r line || [ -n "$line" ]; do
    if [ -d "$source_d/$line" ]; then
      from="$source_d/$line"
      to="$dest_d/$line"
    elif [ -f "$source_f/$line" ]; then
      from="$source_f/$line"
      to="$dest_f/$line"
    else
      color $RED "[FAIL] $line does not exist on your machine"
      exit 1
    fi

    relativize label "$to"

    if [ -e "$to" ]; then
      printf "${YELLOW}[mod]${NORMAL} $label\n"
    else
      printf "${GREEN}[add]${NORMAL} $label\n"
    fi
  done < ".config"

  echo
  read -p "Do you want to continue? (y\n): " commit

  if [ "$commit" != 'y' ]; then
    echo "Ok. Not doing anything."
    exit 0
  fi
}

pull_and_sync() {
  echo
  color $BLUE "Pulling latest changes"
  git pull origin main

  if [ "$?" -ne "0" ]; then
    color $RED "[FAIL] Could not pull latest changes."
    exit 1
  fi

  echo
  color $BLUE "Previewing local modifications"

  preview_changes "." "." "$HOME" "$HOME/.config"

  while read -r line || [ -n "$line" ]; do
    if [ -d "$line" ]; then
      cp -r $line "$HOME/.config"
    elif [ -f "$line" ]; then
      cp $line "$HOME/"
    else
      color $RED "[FAIL] [$line] does not exist in .dotfiles"
      exit 1
    fi
  done < ".config" 

  color $GREEN "Synced successfully."
}

sync_and_push() {
  echo
  color $BLUE "Copying over local config"

  preview_changes "$HOME" "$HOME/.config" "." "."

  while read -r line || [ -n "$line" ]; do
    if [ -d "$HOME/.config/$line" ]; then
      cp -r "$HOME/.config/$line" .
    elif [ -f "$HOME/$line" ]; then
      cp "$HOME/$line" .
    else
      color $RED "[FAIL] [$line] does not exist in your system"
      exit 1
    fi
  done < ".config"

  color $GREEN "Synced successfully."

  if git diff --quiet && git diff --cached --quiet; then
    echo "No new changes detected!"
    exit 0

  git pull origin main
  if [ $? -ne "0" ]; then
    color $RED "Could not pull latest changes from git"
    exit 1
  fi

  git add .
  git status
  read -p "Enter commit message: " commit_message
  git commit -m "$commit_message"
  git push origin main

  if [ $? -eq "0" ]; then 
    color $GREEN "Pushed successfully."
  else
    color $RED "Pushing changes to remote failed."
  fi
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
