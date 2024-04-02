# AppContainer-Proxy-Access
This repository provides [scripts](Scripts) (for Windows) to work around an issue where Microsoft Apps are blocked from accessing to local proxy (with loopback IP) by default, and then unable to connect to the internet. They are especially for people who are using [V2RayN](https://github.com/2dust/v2rayN) for network tunneling.

Provides a Windows PowerShell `.ps1` script [AppxPackage_Loopback_Exemption.ps1](Scripts/AppxPackage_Loopback_Exemption.ps1) to scan all installed AppContainers/AppxPackages and add them to loopback exempted list; and a batch `.bat` script [Update_WinHTTP_IE_Proxy.bat](Scripts/Update_WinHTTP_IE_Proxy.bat) to import current proxy settings to WinHTTP proxy.

## Usage
These scripts are build for Windows operating system environment. Download and run the scripts via the commands provided.

### *AppxPackage_Loopback_Exemption.ps1*
To run `AppxPackage_Loopback_Exemption.ps1`, execute the following command in Command Prompt:
```
curl "https://raw.githubusercontent.com/chinghungx/AppContainer-Proxy-Access/main/Scripts/AppxPackage_Loopback_Exemption.ps1" > "%HOMEDRIVE%%HOMEPATH%\Downloads\AppxPackage_Loopback_Exemption.ps1" && PowerShell -Command ".'%HOMEDRIVE%%HOMEPATH%\Downloads\AppxPackage_Loopback_Exemption.ps1'"
```
> If you are using a proxy, add `-x {host}:{port}` after `curl`.

. . . or in Windows PowerShell:
```
(Invoke-WebRequest -Uri "https://raw.githubusercontent.com/chinghungx/AppContainer-Proxy-Access/main/Scripts/AppxPackage_Loopback_Exemption.ps1").Content > "$ENV:HOMEDRIVE$ENV:HOMEPATH\Downloads\AppxPackage_Loopback_Exemption.ps1"; ."$ENV:HOMEDRIVE$ENV:HOMEPATH\Downloads\AppxPackage_Loopback_Exemption.ps1"
```

### *Update_WinHTTP_IE_Proxy.bat*
To run `Update_WinHTTP_IE_Proxy.bat`, execute the following command in Command Prompt with **administrator privileges**:
```
curl "https://raw.githubusercontent.com/chinghungx/AppContainer-Proxy-Access/main/Scripts/Update_WinHTTP_IE_Proxy.bat" > "%HOMEDRIVE%%HOMEPATH%\Downloads\Update_WinHTTP_IE_Proxy.bat" && "%HOMEDRIVE%%HOMEPATH%\Downloads\Update_WinHTTP_IE_Proxy.bat"
```
> If you are using a proxy, add `-x {host}:{port}` after `curl`.

<br>

**Note:** All downloaded scripts will be located at `%HOMEDRIVE%%HOMEPATH%\Downloads` (current user's Downloads folder).
