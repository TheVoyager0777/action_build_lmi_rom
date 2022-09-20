@ECHO OFF

set device_name=Redmi K30 Pro

TITLE %device_name% 线刷
color 3f

cd /d "%~dp0"

:LOGO
CLS
ECHO.
ECHO.                %device_name%
ECHO.***********************************************
ECHO.                  ROM基本信息
ECHO.
ECHO.             适配机型：%device_name%
ECHO.           
ECHO.***********************************************
ECHO.
ECHO.按任意键继续...
pause>nul

if exist super.zst (
   echo.正在转换 super.zst
   bin\Windows\zstd.exe --rm -d super.zst -o super.img
   if "%ERRORLEVEL%" neq "0" (
      echo.转换失败！
      pause
      exit
   )
)

:ERA
set /p clearn="ERA:是否需要清除你的数据与内部存储？(Y/N) "
if /i "%clearn%" == "y" (
    goto CLS
) else if /i "%clearn%" == "n" (
    goto CLS
) else (
    goto ERA
)

:CLS
ECHO.
ECHO.                %device_name%
ECHO.***********************************************
ECHO.
ECHO.                  刷入底层文件
ECHO.
ECHO.***********************************************
ECHO.
bin\Windows\fastboot.exe %* flash abl firmware-update\abl.elf
bin\Windows\fastboot.exe %* flash ablbak firmware-update\abl.elf
bin\Windows\fastboot.exe %* flash aop firmware-update\aop.mbn
bin\Windows\fastboot.exe %* flash aopbak firmware-update\aop.mbn
bin\Windows\fastboot.exe %* flash bluetooth firmware-update\BTFM.bin
bin\Windows\fastboot.exe %* flash cmnlib firmware-update\cmnlib.mbn
bin\Windows\fastboot.exe %* flash cmnlibbak firmware-update\cmnlib.mbn
bin\Windows\fastboot.exe %* flash cmnlib64 firmware-update\cmnlib64.mbn
bin\Windows\fastboot.exe %* flash cmnlib64bak firmware-update\cmnlib64.mbn
bin\Windows\fastboot.exe %* flash devcfg firmware-update\devcfg.mbn
bin\Windows\fastboot.exe %* flash devcfgbak firmware-update\devcfg.mbn
bin\Windows\fastboot.exe %* flash dsp firmware-update\dspso.bin
bin\Windows\fastboot.exe %* flash dtbo firmware-update\dtbo.img
bin\Windows\fastboot.exe %* flash featenabler firmware-update\featenabler.mbn
bin\Windows\fastboot.exe %* flash hyp firmware-update\hyp.mbn
bin\Windows\fastboot.exe %* flash hypbak firmware-update\hyp.mbn
bin\Windows\fastboot.exe %* flash keymaster firmware-update\km4.mbn
bin\Windows\fastboot.exe %* flash logo firmware-update\logo.img
bin\Windows\fastboot.exe %* flash modem firmware-update\NON-HLOS.bin
bin\Windows\fastboot.exe %* flash qupfw firmware-update\qupv3fw.elf
bin\Windows\fastboot.exe %* flash qupfwbak firmware-update\qupv3fw.elf
bin\Windows\fastboot.exe %* flash storsec firmware-update\storsec.mbn
bin\Windows\fastboot.exe %* flash storsecbak firmware-update\storsec.mbn
bin\Windows\fastboot.exe %* flash tz firmware-update\tz.mbn
bin\Windows\fastboot.exe %* flash tzbak firmware-update\tz.mbn
bin\Windows\fastboot.exe %* flash uefisecapp firmware-update\uefi_sec.mbn
bin\Windows\fastboot.exe %* flash vbmeta_system firmware-update\vbmeta_system.img
bin\Windows\fastboot.exe %* flash vbmeta firmware-update\vbmeta.img
bin\Windows\fastboot.exe %* flash xbl_4 firmware-update\xbl_4.elf
bin\Windows\fastboot.exe %* flash xbl_5 firmware-update\xbl_5.elf
bin\Windows\fastboot.exe %* flash xbl_config_4 firmware-update\xbl_config_4.elf
bin\Windows\fastboot.exe %* flash xbl_config_5 firmware-update\xbl_config_5.elf
bin\Windows\fastboot.exe %* flash boot boot.img

@REM flash firmware done

:MAIN

if exist super.img bin\Windows\fastboot.exe %* flash super super.img
echo.开始刷入super镜像，此文件较大，耗时可能较长。
echo.刷完super可能会卡一会，请耐心等待！！！

if /i "%clearn%" == "y" (
    ECHO. 开始清除数据与内部存储
    bin\Windows\fastboot.exe %* erase metadata
    bin\Windows\fastboot.exe %* erase userdata
)

echo. 刷入完成(按任意键重启手机)
pause >NUL
bin\Windows\fastboot.exe %* reboot

echo. 线刷执行完毕(按任意键关闭脚本)
pause >NUL
EXIT


