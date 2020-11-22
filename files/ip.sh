#!/bin/bash

source ./files/progress-bar.sh
source ./files/summary.sh

########################################################


logs=$(cat ./files/logs.txt)
filename=./files/summary.html
interval=$(cat ./files/config)

########################################################

function speedtest() {
  echo "starting speedtest -- please stand by"
  speed=$(speedtest-cli --simple)
  clear
  echo "current connection details:
  $speed"
}

function timestamp() {
    time=$(date "+%Y-%m-%d %H-%M-%S")
    echo "It is now $time"
}

function retry() {
  while [ -z "$IP" ] # keep trying!
  do
      sleep 10
      IP=$(wget http://ipecho.net/plain -O - -q)
  done
}

######################################################

while :
do
  echo "next check in:"
  progress-bar $interval
  IP=$(wget http://ipecho.net/plain -O - -q)
  CURRENT_IP=$(cat ./files/ip.txt);

if [ -z "$IP" ]; then
    retry
elif [ "$CURRENT_IP" == "$IP" ]; then
    clear
    echo "IP hat sich nicht geändert und ist immernoch $IP"
else
    clear
    echo "IP hat sich geändert - fuck O2"
    echo $IP > ./files/ip.txt
    timestamp
    curl -s http://sync.afraid.org/u/****************************/
    speedtest
    echo "<tr><th rowspan="2">$time</th><td>$IP</td></tr><tr><td>$speed</td></tr>" >> ./files/logs.txt
    write_page > $filename
    cp ./files/summary.html /var/www/html/index.html
    echo "done"
    sleep 5
fi
done
