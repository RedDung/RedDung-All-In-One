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
    echo -e "${yellow}  [1]${nc} Auto tải Delta Executor"
    echo -e "${yellow}  [2]${nc} Auto tải Arceus X"
    echo -e "${yellow}  [3]${nc} Cài đặt APK (Thư mục Download)"
    echo -e "${yellow}  [4]${nc} Kiểm tra IP / Dọn dẹp"
    echo -e "${red}  [0]${nc} Thoát"
    echo -e "${cyan}==========================================${nc}"
    
    read -p "Lựa chọn của bạn: " opt < /dev/tty

    case $opt in
        1)
            echo -e "\n${green}[*] Đang tìm link Delta mới nhất...${nc}"
            # Tự động lấy link từ repo Delta-Clone của bạn hoặc nguồn tương đương
            link=$(curl -s https://api.github.com/repos/RedDung/Delta-Clone/releases/latest | grep "browser_download_url" | cut -d '"' -f 4)
            if [ -z "$link" ]; then
                echo -e "${red}[!] Không tìm thấy file!${nc}"
            else
                echo -e "${green}[+] Đang tải Delta về thư mục Download...${nc}"
                curl -L "$link" -o /sdcard/Download/Delta_Latest.apk
                echo -e "${green}[OK] Đã tải xong!${nc}"
            fi
            ;;
        2)
            echo -e "\n${green}[*] Đang tìm link Arceus X mới nhất...${nc}"
            link=$(curl -s https://api.github.com/repos/RedDung/Arceus-Clone/releases/latest | grep "browser_download_url" | cut -d '"' -f 4)
            if [ -z "$link" ]; then
                echo -e "${red}[!] Không tìm thấy file!${nc}"
            else
                echo -e "${green}[+] Đang tải Arceus về thư mục Download...${nc}"
                curl -L "$link" -o /sdcard/Download/Arceus_Latest.apk
                echo -e "${green}[OK] Đã tải xong!${nc}"
            fi
            ;;
        3)
            echo -e "\n${yellow}[*] Đang quét file APK trong thư mục Download...${nc}"
            cd /sdcard/Download
            files=$(ls *.apk 2>/dev/null)
            if [ -z "$files" ]; then
                echo -e "${red}[!] Không có file APK nào để cài!${nc}"
            else
                for apk in $files; do
                    echo -e "${cyan}[>] Đang cài: $apk...${nc}"
                    su -c "pm install -r $apk"
                done
                echo -e "${green}[OK] Đã cài đặt xong tất cả!${nc}"
            fi
            ;;
        4)
            echo -e "\n${green}[*] IP hiện tại: $(curl -s ifconfig.me)${nc}"
            echo -e "${yellow}[*] Đang dọn dẹp hệ thống...${nc}"
            apt autoremove -y && apt clean
            sleep 1
            ;;
        0) exit 0 ;;
        *) echo -e "\n${red}[!] Chọn sai rồi sếp!${nc}"; sleep 1 ;;
    esac
    
    echo -e "\n${yellow}>> Nhấn [Enter] để về Menu...${nc}"
    read < /dev/tty
done
