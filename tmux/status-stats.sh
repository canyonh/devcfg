#!/usr/bin/env bash
# CPU and memory usage with color coding for tmux status bar
# Green (<60%), Yellow (60-85%), Red (>85%)

colorize() {
  local val=$1
  if [ "$val" -ge 85 ]; then
    echo "#[fg=colour196]${val}%#[fg=colour250]"
  elif [ "$val" -ge 60 ]; then
    echo "#[fg=colour226]${val}%#[fg=colour250]"
  else
    echo "#[fg=colour82]${val}%#[fg=colour250]"
  fi
}

battery() {
  local bat=/sys/class/power_supply/BAT0
  [ -r "$bat/capacity" ] || return
  local cap status icon color
  cap=$(<"$bat/capacity")
  status=$(<"$bat/status")
  case "$status" in
    Charging) icon="+" ;;
    Full)     icon="=" ;;
    *)        icon="-" ;;
  esac
  if [ "$cap" -le 15 ]; then
    color="colour196"
  elif [ "$cap" -le 30 ]; then
    color="colour226"
  else
    color="colour82"
  fi
  echo " BAT:#[fg=${color}]${cap}%${icon}#[fg=colour250]"
}

cpu=$(vmstat 1 2 | tail -1 | awk '{printf "%.0f", 100-$15}')
mem=$(awk '/MemTotal/{t=$2} /MemAvailable/{printf "%.0f", (t-$2)/t*100}' /proc/meminfo)
disk_free=$(df -BG / | awk 'NR==2 {gsub("G","",$4); print $4}')
disk_pct=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "CPU:$(colorize "$cpu") MEM:$(colorize "$mem") DISK:$(colorize "$disk_pct") ${disk_free}G$(battery)"
