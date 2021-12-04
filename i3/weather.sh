#!/bin/sh
# shell script to prepend i3status with weather

i3status | (read line && echo "$line" && read line && echo "$line" && read line && echo "$line" && while :
do
  read line
  temp=$(cat ~/.weather.cache | grep -m 1 -Eo -e '-?[[:digit:]].*°C')
  status=$(cat ~/.weather.cache | head -n 3 | tail -n 1 | cut -c 16-)
  echo ",[{\"full_text\":\"${temp}${status}\",\"color\":\"#00FF00\" },${line#,\[}" || exit 1
done)
