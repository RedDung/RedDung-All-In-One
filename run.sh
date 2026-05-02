#!/bin/bash

# Màu sắc cho đẹp
cyan='\033[0;36m'
green='\033[0;32m'
yellow='\033[0;33m'
red='\033[0;31m'
nc='\033[0m'

while true; do
    clear
    echo -e "${cyan}=========================================="
    echo -e "       REJOICE TOOL - BY REDDUNG          "
    echo -e "==========================================${nc}"
    echo -e "${yellow}  [1]${nc} Cập nhật Tool/Tải Script"
    echo -e "${yellow}  [2]${nc} Mod Interface Minecraft"
    echo -e "${yellow}  [3]${nc} Kiểm tra IP mạng"
    echo -e "${red}  [0]${nc} Thoát"
    echo -e "${cyan}==========================================${nc}"
    
    read -p "Chọn số: " opt

    case $opt in
        1)
            echo -e "${green}Đang tải cập nhật...${nc}"
            # Dán code tải APK/GitHub cũ của bạn vào đây
            sleep 2
            ;;
        2)
            echo -e "${green}Đang fix Interface Minecraft...${nc}"
            # Dán code sửa durability/inventory cũ của bạn vào đây
            sleep 2
            ;;
        3)
            echo -e "${green}IP của bạn là:${nc}"
            curl -s ifconfig.me
            echo ""
            ;;
        0) exit 0 ;;
        *) echo -e "${red}Lựa chọn sai!${nc}"; sleep 1 ;;
    esac
    echo -e "\n${yellow}Nhấn Enter để quay lại Menu...${nc}"
    read
done

