#!/bin/bash

show_help () {
  echo "th.sh [OPTIONS]"
  echo "  -h    Show help"
  echo "  -d    Start directory"
  echo "  -n    Session name"
}

OPTIND=1
start_dir=""
session_name="sess"

while getopts "hn:d:" opt; do
  case "$opt" in
    h)
      show_help
      exit 0
      ;;

    d)
      start_dir=$OPTARG
      ;;

    n)
      session_name=$OPTARG
      ;;
  esac
done

shift $((OPTIND-1))
[ "$1" = "--" ] && shift

if [[ ! -z $start_dir ]]; then
  cd $start_dir
fi

#Create the initial session
tmux new -d -s "$session_name"

#Create the fed window
tmux rename-window "fed"

#Create the bed window
tmux new-window
tmux rename-window "bed"

#Create the cli window
tmux new-window
tmux rename-window "config"
tmux split-window -h
tmux split-window -v

# Reattach to the new session
tmux a -t "$session_name"
