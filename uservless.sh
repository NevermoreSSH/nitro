#!/bin/bash
# =========================================
# Quick Setup | Script Setup Manager
# Edition : Stable Edition V1.0
# Auther  : NevermoreSSH
# (C) Copyright 2022
# =========================================
clear
MYIP=$(wget -qO- ipv4.icanhazip.com);
NUMBER_OF_CLIENTS=$(grep -c -E "^#& " "/etc/xray/config.json")
        if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
                echo -e "---------------------------------------------------"
                echo -e "---------=[ Check XRAYS/Vless WS Config ]=---------"
                echo -e "---------------------------------------------------"
                echo ""
                echo "You have no existing clients!"
                clear
                exit 1
        fi

        echo -e "---------------------------------------------------"
        echo -e "---------=[ Check XRAYS/Vless WS Config ]=---------"
        echo -e "---------------------------------------------------"
        echo " Select the existing client to view the config"
        echo " Press CTRL+C to return"
		echo -e "---------------------------------------------------"
        echo "     No  Expired   User"
        grep -E "^^#& " "/etc/xray/config.json" | cut -d ' ' -f 2-3 | nl -s ') '
        until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
                if [[ ${CLIENT_NUMBER} == '1' ]]; then
                        read -rp "Select one client [1]: " CLIENT_NUMBER
                else
                        read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
                fi
        done
clear
user=$(grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
domain=$(cat /etc/xray/domain)
uuid=$(grep "},{" /etc/xray/config.json | cut -b 11-46 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^#& " "/etc/xray/config.json" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
hariini=`date -d "0 days" +"%Y-%m-%d"`
tls="$(cat ~/log-install.txt | grep -w "Vless TLS" | cut -d: -f2|sed 's/ //g')"
nontls="$(cat ~/log-install.txt | grep -w "Vless None TLS" | cut -d: -f2|sed 's/ //g')"

vlesslink1="vless://${uuid}@${domain}:443?path=/vless&security=tls&encryption=none&type=ws#${user}"
vlesslink2="vless://${uuid}@${domain}:80?path=/vless&encryption=none&type=ws#${user}"
vlesslink3="vless://${uuid}@${domain}:443?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=${domain}#${user}"

clear
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "\E[0;41;36m    Xray/Vless Account     \E[0m" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Remarks     : ${user}" | tee -a /root/akun/vless/$user.txt
echo -e "Domain      : ${domain}" | tee -a /root/akun/vless/$user.txt
echo -e "port TLS    : 443" | tee -a /root/akun/vless/$user.txt
echo -e "Port DNS    : 443" | tee -a /root/akun/vless/$user.txt
echo -e "Port NTLS   : 80" | tee -a /root/akun/vless/$user.txt
echo -e "User ID     : ${uuid}" | tee -a /root/akun/vless/$user.txt
echo -e "Encryption  : none" | tee -a /root/akun/vless/$user.txt
echo -e "Path TLS    : /vless " | tee -a /root/akun/vless/$user.txt
echo -e "ServiceName : vless-grpc" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link TLS    : ${vlesslink1}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link NTLS   : ${vlesslink2}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Link GRPC   : ${vlesslink3}" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Format OpenClash : https://${domain}:81/vless-$user.txt" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "Expired On : $exp" | tee -a /root/akun/vless/$user.txt
echo -e "\033[1;93m───────────────────────────\033[0m" | tee -a /root/akun/vless/$user.txt
echo -e "" | tee -a /root/akun/vless/$user.txt
read -n 1 -s -r -p "Press any key to back on menu"

menu-vless
