#!/bin/bash
# Called by tmux pane-border-format per pane
# Args: <active> <index> <command> <path>
active=$1
index=$2
cmd=$3
path=$4

branch=$(cd "$path" && git branch --show-current 2>/dev/null || echo "-")

if [ "$active" = "1" ]; then
    # Powerline style: gray > blue > green
    printf "#[fg=colour255]#[bg=colour240] %s: %s " "$index" "$cmd"
    printf "#[fg=colour240]#[bg=colour24]"
    printf "#[fg=colour255]#[bg=colour24] %s " "$path"
    printf "#[fg=colour24]#[bg=colour76]"
    printf "#[fg=colour16]#[bg=colour76] %s " "$branch"
    printf "#[fg=colour76]#[bg=default]"
    printf "#[default]"
else
    printf " %s: %s | %s | %s " "$index" "$cmd" "$path" "$branch"
fi
