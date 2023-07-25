#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : NevermoreSSH
# (C) Copyright 2022
# =========================================
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
nontls="$(cat ~/log-install.txt | grep -w "Vmess None TLS" | cut -d: -f2|sed 's/ //g')"
domain=$(cat /etc/xray/domain)
uuid=$(grep "},{" /etc/xray/config.json | cut -b 11-46 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=`date -d "0 days" +"%Y-%m-%d"`
#vmess_base641=$( base64 -w 0 <<< $vmess_json1)
#vmess_base642=$( base64 -w 0 <<< $vmess_json2)
#xrayv2ray1="vmess://$(base64 -w 0 /etc/xray/vmess-$user-tls.json)"
#xrayv2ray2="vmess://$(base64 -w 0 /etc/xray/vmess-$user-nontls.json)"
vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)
vmess_base644=$( base64 -w 0 <<< $vmess_json4)
vmess_base645=$( base64 -w 0 <<< $vmess_json5)
vmess_base646=$( base64 -w 0 <<< $vmess_json6)
vmess_base647=$( base64 -w 0 <<< $vmess_json7)
vmesslink1="vmess://$(echo $asu | base64 -w 0)"
vmesslink2="vmess://$(echo $ask | base64 -w 0)"
vmesslink3="vmess://$(echo $asi | base64 -w 0)"
vmesslink4="vmess://$(echo $aso | base64 -w 0)"
vmesslink5="vmess://$(echo $grpc | base64 -w 0)"
vmesslink6="vmess://$(echo $ama | base64 -w 0)"
vmesslink7="vmess://$(echo $ami | base64 -w 0)"
clear
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "\\E[0;41;36m        Xray/Vmess Account        \E[0m" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Remarks   : ${user}" | tee -a /etc/log-create-user.log
echo -e "Domain    : ${domain}" | tee -a /etc/log-create-user.log
echo -e "Port TLS  : ${tls}" | tee -a /etc/log-create-user.log
echo -e "Port NTLS : ${none}" | tee -a /etc/log-create-user.log
echo -e "Port GRPC : ${tls}" | tee -a /etc/log-create-user.log
echo -e "id        : ${uuid}" | tee -a /etc/log-create-user.log
echo -e "alterId   : 0" | tee -a /etc/log-create-user.log
echo -e "Security  : auto" | tee -a /etc/log-create-user.log
echo -e "Network   : ws/grpc" | tee -a /etc/log-create-user.log
echo -e "Path      : /vmess" | tee -a /etc/log-create-user.log
echo -e "Path      : /worryfree" | tee -a /etc/log-create-user.log
#echo -e "Path     : /kuota-habis" | tee -a /etc/log-create-user.log
echo -e "SerName   : vmess-grpc" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link TLS : ${vmesslink1}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link none TLS : ${vmesslink2}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link (WORRYFREE) : ${vmesslink3}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link none (FLEX) : ${vmesslink4}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Link GRPC : ${vmesslink5}" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo -e "Expired On : $exp" | tee -a /etc/log-create-user.log
echo -e "----------------------------------" | tee -a /etc/log-create-user.log
echo "" | tee -a /etc/log-create-user.log
rm /etc/xray/$user-tls.json > /dev/null 2>&1
rm /etc/xray/$user-none.json > /dev/null 2>&1
read -n 1 -s -r -p "Press any key to back on menu"

menu-vmess
