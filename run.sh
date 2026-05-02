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
            curl -s https://api.github.com/repos/RedDung/Delta-Clone/releases/tags/Clone_Roblox | grep "browser_download_url" | cut -d '"' -f 4 | grep ".apk" | wget -i - -q --show-progress
            mv *.apk /sdcard/Download/ 2>/dev/null
            echo -e "${green}--- Hoàn thành ---${nc}"
            ;;
        2)
            echo -e "\n${green}[*] Đang tải Arceus X...${nc}"
            curl -s https://api.github.com/repos/RedDung/Arceus-Clone/releases/tags/Arceus_Clone | grep "browser_download_url" | cut -d '"' -f 4 | grep ".apk" | wget -i - -q --show-progress
            mv *.apk /sdcard/Download/ 2>/dev/null
            echo -e "${green}--- Hoàn thành ---${nc}"
            ;;
        3)
            echo -e "\n${yellow}[*] Đang cài đặt tất cả APK...${nc}"
            cd /sdcard/Download 2>/dev/null
            for apk in *.apk; do
                [ -e "$apk" ] || continue
                echo -e "${cyan}[>] Đang cài: $apk${nc}"
                su -c "pm install -r $apk"
            done
            ;;
        4)
            echo -e "\n${yellow}[*] Đang tối ưu hệ thống...${nc}"
            export DEBIAN_FRONTEND=noninteractive
            pkg update -y -o Dpkg::Options::="--force-confold"
            pkg upgrade -y -o Dpkg::Options::="--force-confold"
            pkg install curl wget grep -y
            echo -e "${green}[OK] Môi trường đã sẵn sàng!${nc}"
            ;;
        0) exit 0 ;;
        *) echo -e "\n${red}[!] Nhập sai rồi sếp!${nc}"; sleep 1 ;;
    esac
    
    echo -e "\n${yellow}>> Nhấn [Enter] để về Menu...${nc}"
    read < /dev/tty
done
