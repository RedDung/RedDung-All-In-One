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
    
    # Đọc phím từ bàn phím (/dev/tty)
    read -p "Lựa chọn của bạn: " opt < /dev/tty

    case $opt in
        1)
            echo -e "${green}[*] Đang kiểm tra cập nhật trên GitHub...${nc}"
            sleep 2
            ;;
        2)
            echo -e "${green}[*] Thông tin mạng của bạn:${nc}"
            echo -n "Public IP: "
            curl -s ifconfig.me
            echo -e "\n"
            ;;
        3)
            echo -e "${yellow}[*] Đang dọn dẹp các gói thừa...${nc}"
            apt autoremove -y && apt clean
            echo -e "${green}[OK] Đã dọn dẹp xong!${nc}"
            sleep 1
            ;;
        4)
            echo -e "${cyan}[!] Mục này đang trống, chờ sếp thêm code!${nc}"
            sleep 2
            ;;
        0) 
            echo -e "${green}Tạm biệt! Hẹn gặp lại.${nc}"
            exit 0 
            ;;
        *) 
            echo -e "${red}[!] Nhập sai rồi, chọn từ 0 đến 4 thôi!${nc}"
            sleep 1 
            ;;
    esac
    
    echo -e "\n${yellow}------------------------------------------"
    echo -e "Nhấn [Enter] để quay lại Menu...${nc}"
    read < /dev/tty
done
