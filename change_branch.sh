#!/bin/bash

read -p "Enter a match word: " USER_INPUT
if [[ $USER_INPUT != "" ]]; then
	# Changing branch
  git checkout $USER_INPUT

	# Pulling latest edits
	git pull
else
	echo "Missing branch name"
fi
