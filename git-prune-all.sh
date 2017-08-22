#!/bin/bash

current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
if [ "$current_branch" != "master" ]; then
  echo "WARNING: You are on branch $current_branch, NOT master."
fi
echo -e "Fetching merged branches...\n"

git remote update --prune
remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
  echo "No existing branches have been merged into $current_branch."
else
  echo "This will remove the following branches:"
  if [ -n "$remote_branches" ]; then
    echo "Remote branches:"
    echo "$remote_branches"
    read -p "Continue? (y/N): " -n 1 choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      echo
      # remotes=`echo "$remote_branches" | sed 's/\(.*\)\/\(.*\)/\1/g' | sort -u`
      remotes=origin
      echo $remotes
      # Remove remote branches
      for remote in $remotes
      do
          branches=`echo "$remote_branches" | grep "$remote/" | sed 's/\(.*\)\/\(.*\)/\2 /g' | tr -d '\n'`
          git push --delete $remote $branches
      done
    else
      echo "No remote branches removed."
    fi
    echo
  fi

  if [ -n "$local_branches" ]; then
    echo "Local branches:"
    echo "$local_branches"
    read -p "Continue? (Y/n): " -n 1 choice
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ] || [ "$choice" == "" ]; then
      echo
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
      echo "No local branches removed."
    fi
  else
    echo "No local branches to remove"
  fi
  echo
fi
