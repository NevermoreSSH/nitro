
# Autoscript SSH & XRAY MULTIPORT 443 & 80

## For ubuntu 18.04/20.04 @ Debian 9/10,11 <br>

## Step 1 update Debian 9/10/11
```
apt update -y && apt upgrade -y && apt dist-upgrade -y && reboot
 ```
## Step 1 update Ubuntu 18/20
```
apt-get update && apt-get upgrade -y && apt dist-upgrade -y && update-grub && reboot

 ```
## Installation Link<br>

  ```html
sysctl -w net.ipv6.conf.all.disable_ipv6=1 && sysctl -w net.ipv6.conf.default.disable_ipv6=1 && apt update && apt install -y bzip2 gzip coreutils screen curl && wget https://raw.githubusercontent.com/NevermoreSSH/nitro/main/setupku.sh && chmod +x setupku.sh && sed -i -e 's/\r$//' setupku.sh && screen -S setup ./setupku.sh

  ```
## Fitur:
<br>
✅ SSH WEBSOCKET TLS & NON-TLS 443/80 MULTIPATH<br>
✅ SSH WEBSOCKET TLS & NON-TLS 443/80 MULTIPATH<br>
✅ SSH SLOW DNS<br>
✅ SSH UDP<br>
✅ XRAY VMESS WEBSOCKET TLS & NON-TLS 443/80 MULTIPATH<br>
✅ XRAY VLESS WEBSOCKET TLS & NON-TLS 443/80<br>
✅ XRAY TROJAN WEBSOCKET TLS & NON-TLS 443/80<br>
✅ XRAY TROJAN TCP XTLS 443<br>
✅ XRAY TROJAN TCP TLS 443<br>

            
              
