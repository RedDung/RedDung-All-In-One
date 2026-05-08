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
    echo -e "${yellow}  [5]${nc} Tải APK từ Link URLVN"
    echo -e "${green}  [6]${nc} Tự động Check Cookie (Từ Download)${nc}"
    echo -e "${red}  [0]${nc} Thoát"
    echo -e "${cyan}==========================================${nc}"
    
    read -p "Lựa chọn của bạn: " opt < /dev/tty

    case $opt in
        1)
            echo -e "\n${green}[*] Đang tải Delta...${nc}"
            rm -f *.apk 2>/dev/null
            LINKS=$(curl -s https://api.github.com/repos/RedDung/Delta-Clone/releases/tags/Clone_Roblox | grep "browser_download_url" | grep ".apk" | cut -d '"' -f 4)
            if [ -z "$LINKS" ]; then echo -e "${red}[!] Không tìm thấy file!${nc}"; else
                for link in $LINKS; do wget -c --tries=0 "$link" -q --show-progress; done
                mv *.apk /sdcard/Download/ 2>/dev/null
                echo -e "${green}--- Hoàn thành ---${nc}"
            fi
            ;;
        2)
            echo -e "\n${green}[*] Đang tải Arceus X...${nc}"
            rm -f *.apk 2>/dev/null
            LINKS=$(curl -s https://api.github.com/repos/RedDung/Arceus-Clone/releases/tags/Arceus_Clone | grep "browser_download_url" | grep ".apk" | cut -d '"' -f 4)
            if [ -z "$LINKS" ]; then echo -e "${red}[!] Không tìm thấy file!${nc}"; else
                for link in $LINKS; do wget -c --tries=0 "$link" -q --show-progress; done
                mv *.apk /sdcard/Download/ 2>/dev/null
                echo -e "${green}--- Hoàn thành ---${nc}"
            fi
            ;;
        3)
            echo -e "\n${yellow}[*] Đang cài đặt tất cả APK...${nc}"
            cd /sdcard/Download/ 2>/dev/null || termux-setup-storage
            rm -f *.apk.1 *.apk.2 2>/dev/null
            for f in *.apk; do
                if [ -f "$f" ]; then
                    echo -e "${cyan}--------------------------------"
                    echo -e "[>] Đang ép cài đặt: $f${nc}"
                    path=$(realpath "$f")
                    su -c "cp '$path' /data/local/tmp/t.apk && pm install -r -d --user 0 /data/local/tmp/t.apk && rm /data/local/tmp/t.apk"
                fi
            done
            echo -e "\n${green}[!] Xong!${nc}"
            ;;
        4)
            echo -e "\n${yellow}[*] Đang cập nhật môi trường...${nc}"
            pkg update -y && pkg upgrade -y && pkg install curl wget python -y
            pip install requests
            echo -e "${green}[OK] Đã sẵn sàng!${nc}"
            ;;
        5)
            echo -e "\n${green}[*] Đang tải file từ URLVN...${nc}"
            rm -f *.apk 2>/dev/null
            wget -c --content-disposition "https://urlvn.net/apnnt1v" -q --show-progress
            mv *.apk /sdcard/Download/ 2>/dev/null
            echo -e "${green}--- Tải thành công! File đã nằm trong Download ---${nc}"
            ;;
        6)
            echo -e "\n${cyan}--- ĐANG QUÉT COOKIE TỪ THƯ MỤC DOWNLOAD ---${nc}"
            FILE_PATH="/sdcard/Download/check_cookie.txt"
            
            if [ ! -f "$FILE_PATH" ]; then
                echo -e "${red}[!] Không thấy file check_cookie.txt trong Download!${nc}"
            else
                # Tạo file python xử lý API ngầm để đảm bảo chính xác 100%
                cat <<EOF > check_logic.py
import requests
import os

def check():
    try:
        with open('temp_list.txt', 'r') as f:
            lines = [l.strip() for l in f.readlines() if l.strip()]
        
        print(f"[*] Tìm thấy {len(lines)} tài khoản. Đang check qua API...")
        for line in lines:
            parts = line.split(':')
            if len(parts) < 3: continue
            user, cookie = parts[0], parts[2]
            
            try:
                r = requests.get("https://users.roblox.com/v1/users/authenticated", 
                                 headers={"Cookie": f".ROBLOSECURITY={cookie}"}, timeout=10)
                if r.status_code == 200:
                    print(f"\033[0;32m[LIVE] {user} - Ngon lành! ✅\033[0m")
                else:
                    print(f"\033[0;31m[DIE]  {user} - Đã ngỏm! ❌\033[0m")
            except:
                print(f"\033[0;33m[LỖI]  {user} - Lỗi kết nối.\033[0m")
    except Exception as e:
        print(f"Lỗi: {e}")

if __name__ == "__main__":
    check()
EOF
                # Sao chép file vào môi trường làm việc của Termux
                cp "$FILE_PATH" ./temp_list.txt
                python3 check_logic.py
                # Dọn dẹp file tạm
                rm check_logic.py temp_list.txt
            fi
            ;;
        0) exit 0 ;;
        *) echo -e "\n${red}[!] Nhập sai rồi sếp!${nc}"; sleep 1 ;;
    esac
    
    echo -e "\n${yellow}>> Nhấn [Enter] để về Menu...${nc}"
    read < /dev/tty
done

