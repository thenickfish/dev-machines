Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
$env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
refreshenv
choco install /tmp/packages.config -y --no-progress

refreshenv

git config --global user.name "Nick Fish"
git config --global user.email "thenickfish@gmail.com"

code --install-extension ms-vscode.powershell --force
code --install-extension esbenp.prettier-vscode --force

ridk install 3
gem install jekyll bundler

npm install -g gulp