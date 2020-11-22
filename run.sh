#!/bin/bash


########################################################


function set_interval() {
  echo -n "Enter time in seconds and press [ENTER]:"
  read interval; echo $interval > ./files/config
  echo "interval set"
  sleep 1
  clear
}

########################################################


HEIGHT=15
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="MyDynupdater"
TITLE="Fuck o2"
MENU="Choose one of the following options:"

OPTIONS=(1 "run in terminal"
         2 "run silent"
         3 "stop all")

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear
case $CHOICE in
        1)
            echo "running in terminal mode"
            sleep 1
            set_interval
            ./files/ip.sh
            ;;
        2)
            echo "running in silent mode"
            sleep 1
            set_interval
            ./files/ip.sh > stdoutfile 2> stderrfile &
            ;;
        3)
            echo "stopping all"
            sleep 1
            pkill ip.sh
            ;;
    esac
fi
