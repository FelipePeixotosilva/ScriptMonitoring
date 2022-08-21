#!/bin/bash
ARCH=$(uname -a)
CPU_PSY=$(lscpu | grep "Socket" | awk '{print $2}')
vCPU=$(cat /proc/cpuinfo | grep "processor" | wc -l)
MM_U=$(free -m | grep "Mem:" | awk '{print $3}')
MM_T=$(free -h | grep "Mem:" | awk '{print $2}')
MM_PER=$(free -m | grep "Mem" | awk '{printf "%.2f", $3/$2*100}')
DU=$(df -m --total | grep "total" | awk '{print $3}')
DT=$(df -h --total | grep "total" | awk '{print $2}')
DPER=$(df -h --total | grep "total" | awk '{printf "%.1f", $3/$2*100}')
CPU_L=$(top -b -n 1 | grep "%Cpu(s)" | awk '{print $2}')
LBootD=$(who -b | grep "system" | awk '{print $3}')
LBootH=$(who -b | grep "system" | awk '{print $4}')
LVMC=$(if [$(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo "no"; else echo "yes"; fi)
CONNECT=$(ss -t | grep "ESTAB" | wc -l)
USER_L=$(users | wc -w)
IP=$(hostname -I)
MAC=$(ip link | grep "link/ether" | awk '{print $2}')
SU=$(journalctl -q | grep sudo | grep COMMAND | wc -l)
wall "
#Architecture: $ARCH
#CPU physical : $CPU_PSY
#vCPU : $vCPU
#Memory Usage: $MM_U/$MM_T ($MM_PER%)
#Disk Usage:$DU/$DT ($DPER%)
#CPU load: $CPU_L%
#Last boot: $LBootD $LBootH
#LVM use: $LVMC
#Connections TCP : $CONNECT ESTABLISHED
#User log: $USER_L
#Network: IP $IP ($MAC)
#Sudo : $SU cmd
"
