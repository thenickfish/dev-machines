Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv

Get-ChildItem C:\tmp\workloads | Where-Object {$_.PsIsContainer} | ForEach-Object {
    Set-Location -Path $_.FullName
    "-------------------------------------- Installing Workload '" + $_.Name + "' --------------------------------------"
    if (Test-Path pre.ps1) {
        "--- Running pre.ps1 ---"
        Invoke-Expression -Command .\pre.ps1
    }
    if (Test-Path packages.config) {
        "--- Installing packages ---"
        choco install packages.config -y --no-progress
    }
    if (Test-Path post.ps1) {
        "--- Running post.ps1 ---"
        refreshenv
        Invoke-Expression -Command .\post.ps1
    }
}

