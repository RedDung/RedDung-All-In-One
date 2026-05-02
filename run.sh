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
    echo -e "${yellow}  [1]${nc} Cập nhật Tool / Tải Script"
    echo -e "${yellow}  [2]${nc} Kiểm tra IP mạng"
    echo -e "${yellow}  [3]${nc} Dọn dẹp hệ thống Termux"
    echo -e "${yellow}  [4]${nc} Tính năng mới (Đang chờ...)"
    echo -e "${red}  [0]${nc} Thoát"
    echo -e "${cyan}==========================================${nc}"
    
    read -p "Lựa chọn của bạn: " opt < /dev/tty

    case $opt in
        1)
            echo -e "\n${green}[*] Đang kiểm tra cập nhật...${nc}"
            sleep 2
            ;;
        2)
            echo -e "\n${green}[*] Thông tin mạng của bạn:${nc}"
            echo -n "Public IP: "
            curl -s ifconfig.me
            echo -e "\n"
            ;;
        3)
            echo -e "\n${yellow}[*] Đang dọn dẹp hệ thống...${nc}"
            apt autoremove -y && apt clean
            echo -e "${green}[OK] Đã hoàn tất!${nc}"
            sleep 1
            ;;
        4)
            echo -e "\n${cyan}[!] Mục này đang chờ bạn thêm code!${nc}"
            sleep 2
            ;;
        0) 
            echo -e "\n${green}Tạm biệt! Hẹn gặp lại.${nc}"
            exit 0 
            ;;
        *) 
            echo -e "\n${red}[!] Nhập sai rồi, hãy chọn lại!${nc}"
            sleep 1 
            ;;
    esac
    
    # Bỏ dòng gạch ngang rườm rà, dùng dòng này cho gọn
    echo -e "${yellow}>> Nhấn [Enter] để về Menu...${nc}"
    read < /dev/tty
done
