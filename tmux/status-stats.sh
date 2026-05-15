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

cpu=$(vmstat 1 2 | tail -1 | awk '{printf "%.0f", 100-$15}')
mem=$(awk '/MemTotal/{t=$2} /MemAvailable/{printf "%.0f", (t-$2)/t*100}' /proc/meminfo)
disk_free=$(df -BG / | awk 'NR==2 {gsub("G","",$4); print $4}')
disk_pct=$(df / | awk 'NR==2 {gsub("%","",$5); print $5}')

echo "CPU:$(colorize "$cpu") MEM:$(colorize "$mem") DISK:$(colorize "$disk_pct") ${disk_free}G"
