#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : NevermoreSSH
# (C) Copyright 2022
# =========================================
###########- COLOR CODE -##############
NC="\e[0m"
COLOR1="\033[0;31m" 
###########- END COLOR CODE -#########
clear
MYIP=$(wget -qO- ipv4.icanhazip.com);
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/xray/config.json")
        if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
                echo -e "---------------------------------------------------"
                echo -e "---------=[ Check XRAYS/Vmess WS Config ]=---------"
                echo -e "---------------------------------------------------"
                echo ""
                echo "You have no existing clients!"
                clear
                exit 1
        fi

        echo -e "---------------------------------------------------"
        echo -e "---------=[ Check XRAYS/Vmess WS Config ]=---------"
        echo -e "---------------------------------------------------"
        echo " Select the existing client to view the config"
        echo " Press CTRL+C to return"
		echo -e "---------------------------------------------------"
        echo "     No  Expired   User"
        grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
        until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
                if [[ ${CLIENT_NUMBER} == '1' ]]; then
                        read -rp "Select one client [1]: " CLIENT_NUMBER
                else
                        read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
                fi
        done
user=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
tls="$(cat ~/log-install.txt | grep -w "Vmess TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
domain=$(cat /etc/xray/domain)
uuid=$(grep "},{" /etc/xray/config.json | cut -b 11-46 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=`date -d "0 days" +"%Y-%m-%d"`
#vmess_base641=$( base64 -w 0 <<< $vmess_json1)
#vmess_base642=$( base64 -w 0 <<< $vmess_json2)
#xrayv2ray1="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
#xrayv2ray2="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
asu=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
ask=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "80",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${domain}",
      "tls": "none"
}
EOF`
grpc=`cat<<EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${domain}",
      "port": "443",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${domain}",
      "tls": "tls"
}
EOF`
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $grpc | base64 -w 0)"
clear
echo -e "$COLOR1+-------------------------------------------------+${NC}"
echo -e "$COLOR1¦${NC} ${COLBG1}            • CREATE VMESS USER •              ${NC} $COLOR1¦$NC"
echo -e "$COLOR1+-------------------------------------------------+${NC}"
echo -e "$COLOR1+-------------------------------------------------+${NC}"
echo -e "$COLOR1 ${NC} Remarks       : ${user}"
echo -e "$COLOR1 ${NC} Expired On    : $exp" 
echo -e "$COLOR1 ${NC} Domain        : ${domain}" 
echo -e "$COLOR1 ${NC} Port TLS      : ${tls}" 
echo -e "$COLOR1 ${NC} Port none TLS : ${none}" 
echo -e "$COLOR1 ${NC} Port  GRPC    : ${tls}" 
echo -e "$COLOR1 ${NC} id            : ${uuid}" 
echo -e "$COLOR1 ${NC} alterId       : 0" 
echo -e "$COLOR1 ${NC} Security      : auto" 
echo -e "$COLOR1 ${NC} Network       : ws" 
echo -e "$COLOR1 ${NC} Path          : /vmess" 
echo -e "$COLOR1 ${NC} Path WSS      : wss://bug.com/vmess" 
echo -e "$COLOR1 ${NC} ServiceName   : vmess-grpc" 
echo -e "$COLOR1+-------------------------------------------------+${NC}" 
echo -e "$COLOR1+-------------------------------------------------+${NC}"
echo -e "$COLOR1 ${NC} Link TLS : "
echo -e "$COLOR1 ${NC} ${vmesslink1}" 
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1 ${NC} Link none TLS : "
echo -e "$COLOR1 ${NC} ${vmesslink2}" 
echo -e "$COLOR1 ${NC} "
echo -e "$COLOR1 ${NC} Link GRPC : "
echo -e "$COLOR1 ${NC} ${vmesslink3}"
echo -e "$COLOR1+-------------------------------------------------+${NC}" 
echo -e "$COLOR1+---------------------- BY -----------------------+${NC}"
echo -e "$COLOR1¦${NC}                • NevermoreSSH •                 $COLOR1¦$NC"
echo -e "$COLOR1+-------------------------------------------------+${NC}" 
echo ""

read -n 1 -s -r -p "   Press any key to back on menu"
menu-vmess
