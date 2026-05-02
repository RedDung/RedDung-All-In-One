#!/bin/bash

# Màu sắc
cyan='\033[0;36m'
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
nc='\033[0m'

while true; do
    clear
    echo -e "${cyan}=========================================="
    echo -e "            TOOL - BY REDDUNG             "
    echo -e "==========================================${nc}"
    echo -e "${yellow}  [1]${nc} Auto tải Delta"
    echo -e "${yellow}  [2]${nc} Auto tải Arceus X"
    echo -e "${yellow}  [3]${nc} Cài đặt APK"
    echo -e "${yellow}  [4]${nc} Cập nhật môi trường"
    echo -e "${red}  [0]${nc} Thoát"
    echo -e "${cyan}==========================================${nc}"
    
    read -p "Lựa chọn của bạn: " opt < /dev/tty

    case $opt in
        1)
            echo -e "\n${green}[*] Đang tải Delta...${nc}"
            # Dọn rác cũ để tránh bị đẻ ra file .1, .2
            rm -f delta_temp.apk 2>/dev/null
            LINK=$(curl -s https://api.github.com/repos/RedDung/Delta-Clone/releases/tags/Clone_Roblox | grep "browser_download_url" | cut -d '"' -f 4 | grep ".apk" | head -n 1)
            
            if [ -z "$LINK" ]; then
                echo -e "${red}[!] Không lấy được link tải!${nc}"
            else
                # -c: Tải tiếp nếu đứt mạng, --tries=0: Tải đến khi nào xong thì thôi
                wget -c --tries=0 "$LINK" -q --show-progress -O delta_temp.apk
                mv delta_temp.apk /sdcard/Download/delta.apk 2>/dev/null
                echo -e "${green}--- Hoàn thành ---${nc}"
            fi
            ;;
        2)
            echo -e "\n${green}[*] Đang tải Arceus X...${nc}"
            rm -f arceus_temp.apk 2>/dev/null
            LINK=$(curl -s https://api.github.com/repos/RedDung/Arceus-Clone/releases/tags/Arceus_Clone | grep "browser_download_url" | cut -d '"' -f 4 | grep ".apk" | head -n 1)
            
            if [ -z "$LINK" ]; then
                echo -e "${red}[!] Không lấy được link tải!${nc}"
            else
                wget -c --tries=0 "$LINK" -q --show-progress -O arceus_temp.apk
                mv arceus_temp.apk /sdcard/Download/arceus.apk 2>/dev/null
                echo -e "${green}--- Hoàn thành ---${nc}"
            fi
            ;;
        3)
            echo -e "\n${yellow}[*] Đang cài đặt tất cả APK...${nc}"
            cd /sdcard/Download/ 2>/dev/null || termux-setup-storage
            # Dọn sạch mấy file rác .1 .2 lỗi trước khi cài
            rm -f *.apk.1 *.apk.2 2>/dev/null
            
            for f in *.apk; do
                if [ -f "$f" ]; then
                    echo -e "${cyan}--------------------------------"
                    echo -e "[>] Đang ép cài đặt: $f${nc}"
                    path=$(realpath "$f")
                    su -c "cp '$path' /data/local/tmp/t.apk && pm install -r -d --user 0 /data/local/tmp/t.apk && rm /data/local/tmp/t.apk"
                fi
            done
            echo -e "\n${green}[!] Hoàn thành!${nc}"
            ;;
        4)
            echo -e "\n${yellow}[*] Đang tối ưu hệ thống...${nc}"
            export DEBIAN_FRONTEND=noninteractive
            pkg update -y -o Dpkg::Options::="--force-confold"
            pkg upgrade -y -o Dpkg::Options::="--force-confold"
            pkg install curl wget grep coreutils -y
            echo -e "${green}[OK] Môi trường đã sẵn sàng!${nc}"
            ;;
        0) exit 0 ;;
        *) echo -e "\n${red}[!] Nhập sai rồi sếp!${nc}"; sleep 1 ;;
    esac
    
    echo -e "\n${yellow}>> Nhấn [Enter] để về Menu...${nc}"
    read < /dev/tty
done
