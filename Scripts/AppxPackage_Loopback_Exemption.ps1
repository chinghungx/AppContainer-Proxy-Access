#
# AppContainer Loopback Exemption Script v1.0
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#
# This is a Windows PowerShell (.ps1) script to exempt all AppContainers to
# perform network loopback (sending traffic to network IP 127.0.0.0).
#
# AppContainers/AppxPackages are the Microsoft legacy applications installed
# under AppContainer environment.
#
# By default, AppContainers are not allowed to perform loopback. This will
# prevent internet access against them, especially when a local proxy with
# loopback IP is applied.
#
# This script fixes the problem by scanning all AppxPackages installed in
# current computer by all users and adding them to the loopback exempted list.
#

Write-Host "The script is to add all AppContainers to the loopback exempted list."
Write-Host "NOTICE: This script requires administrator privilege to perform specific commands."
Write-Host "`nChecking the presense of administrator privilege..."

if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    if ([int] (Get-CimInstance -ClassName Win32_OperatingSystem).BuildNumber -ge 6000) {
        Write-Host "The script is not running with administrative privilege. The script will be elevated."
        Write-Host "Please click `"Yes`" when UAC prompt appears."
        $confirm = Read-Host -Prompt "`nProceed to execution [Y/N] ?"

        if ($confirm -ieq "Y") {
            Write-Host "Clearing loopback exempted AppContainer list..."
            $arglist = "-Command `"CheckNetIsolation LoopbackExempt -c; (Get-AppxPackage -AllUsers).PackageFamilyName > '" + (Get-Location).Path + "\AppxPackages.txt'`""
            Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList "$arglist"
            Pause

            Write-Host "Adding AppContainers to loopback exempted list..."
            $commandArr = @()
            Get-Content "AppxPackages.txt" | ForEach-Object { $commandArr += "CheckNetIsolation LoopbackExempt -a -n='$_'" }
            Remove-Item "AppxPackages.txt"
            $commands = $commandArr -join ";"
            $command = "-Command `"" + $commands + "`""
            Start-Process -FilePath PowerShell -Verb RunAs -ArgumentList "$command"

            Write-Host "`nDone."
        }
        else {
            Write-Host "`nOperation aborted."
        }
    }
}
else {
    Write-Host "The script is running with administrator privilege."
    $confirm = Read-Host -Prompt "`nProceed to execution [Y/N] ?"

    if ($confirm -ieq "Y") {

        # Clear the list of loopback exempted AppContainers and Package Families.
        Write-Host "Clearing loopback exempted AppContainer list..."
        CheckNetIsolation LoopbackExempt -c

        # Add all AppContainer or Package Family to the loopback exempted list.
        Write-Host "Adding AppContainers to loopback exempted list..."
        (Get-AppxPackage -AllUsers).PackageFamilyName | ForEach-Object { CheckNetIsolation LoopbackExempt -a -n="$_" }

        Write-Host "`nDone."
    }
    else {
        Write-Host "`nOperation aborted."
    }
}

Pause