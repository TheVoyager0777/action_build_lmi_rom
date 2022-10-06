#!/bin/bash
git clone https://github.com/Meetingfate/action_build_lmi_rom
GITHUB_WORKSPACE=/home/runner/work/action-tmate/action-tmate/action_build_lmi_rom
source "$GITHUB_WORKSPACE"/resource/config.env
ROM_URL=$ROM_URL
camera1=$camera1
camera2=$camera2
sudo apt install python3 python3-pip aria2 zip p7zip-full zipalign
sudo apt --fix-broken install
sudo apt update --fix-missing
pip3 install --upgrade pip
pip3 install pycryptodome
pip3 install docopt
pip3 install requests
pip3 install beautifulsoup4
pip3 install --ignore-installed pyyaml
aria2c -x16 -j$(nproc) -U "Mozilla/5.0" -d "$GITHUB_WORKSPACE" $ROM_URL
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/payload-dumper-go
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/brotli
mkdir -p "$GITHUB_WORKSPACE"/PSYCHE
mkdir -p "$GITHUB_WORKSPACE"/images
mkdir -p "$GITHUB_WORKSPACE"/simages
mkdir -p "$GITHUB_WORKSPACE"/zip
mkdir -p "$GITHUB_WORKSPACE"/firmware
ZIP_NAME_PSYCHE=$(echo $ROM_URL | cut -d"/" -f5)
7z x "$GITHUB_WORKSPACE"/$ZIP_NAME_PSYCHE -r -o"$GITHUB_WORKSPACE"/PSYCHE
rm -rf "$GITHUB_WORKSPACE"/$ZIP_NAME_PSYCHE
    "$GITHUB_WORKSPACE"/tools/payload-dumper-go -p system "$GITHUB_WORKSPACE"/PSYCHE/payload.bin
    mv "$GITHUB_WORKSPACE"/payload/system.img "$GITHUB_WORKSPACE"/images/system.img
    sudo python3 "$GITHUB_WORKSPACE"/tools/imgextractorLinux.py "$GITHUB_WORKSPACE"/images/system.img "$GITHUB_WORKSPACE"/images
    rm -rf "$GITHUB_WORKSPACE"/images/system.img
rm -rf "$GITHUB_WORKSPACE"/payload
rm -rf "$GITHUB_WORKSPACE"/PSYCHE
sudo chmod 777 "$GITHUB_WORKSPACE"/tools/apktool.jar
Apktool="java -jar "$GITHUB_WORKSPACE"/tools/apktool.jar"
echo 导入框架
$Apktool if "$GITHUB_WORKSPACE"/images/system/system/app/miui/miui.apk
$Apktool if "$GITHUB_WORKSPACE"/images/system/system/app/miuisystem/miuisystem.apk
$Apktool if "$GITHUB_WORKSPACE"/images/system/system/framework/framework-res.apk
$Apktool if "$GITHUB_WORKSPACE"/images/system/system/framework/framework-ext-res/framework-ext-res.apk
sudo mkdir -p /root/.local/share/apktool/framework/
sudo mv /home/runner/.local/share/apktool/framework/* /root/.local/share/apktool/framework/