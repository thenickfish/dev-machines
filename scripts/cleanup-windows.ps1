# function Pin-App {
#     param(
#         [string]$appname,
#         [switch]$unpin
#     )
#     try {
#         if ($unpin.IsPresent) {
#             ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ? {$_.Name -eq $appname}).Verbs() | ? {$_.Name.replace('&', '') -match 'From "Start" UnPin|Unpin from Start'} | % {$_.DoIt()}
#             ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ? {$_.Name -eq $appname}).Verbs() | ? {$_.Name.replace('&', '') -match 'From "Taskbar" UnPin|Unpin from Taskbar'} | % {$_.DoIt()}
#             return "App '$appname' unpinned from Start"
#         }
#         else {
#             ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ? {$_.Name -eq $appname}).Verbs() | ? {$_.Name.replace('&', '') -match 'To "Start" Pin|Pin to Start'} | % {$_.DoIt()}
#             ((New-Object -Com Shell.Application).NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').Items() | ? {$_.Name -eq $appname}).Verbs() | ? {$_.Name.replace('&', '') -match 'To "Taskbar" Pin|Pin to Taskbar'} | % {$_.DoIt()}
#             return "App '$appname' pinned to Start"
#         }
#     }
#     catch {
#         Write-Error "Error Pinning/Unpinning App! (App-Name correct?)"
#     }
# }

# Pin-App "Mail" -unpin
# # Pin-App "Store" -unpin
# Pin-App "Calendar" -unpin
# Pin-App "Microsoft Edge" -unpin
# Pin-App "Photos" -unpin
# Pin-App "Cortana" -unpin
# Pin-App "My Office" -unpin
# # Pin-App "Phone Companion" -unpin
# # Pin-App "Music" -unpin
# Pin-App "xbox" -unpin
# Pin-App "movies & tv" -unpin
# Pin-App "microsoft solitaire collection" -unpin
# # Pin-App "money" -unpin
# # Pin-App "get office" -unpin
# Pin-App "onenote" -unpin
# # Pin-App "news" -unpin

# Pin-App "Microsoft Store" -unpin
# Pin-App "Sticky Notes" -unpin
# Pin-App "Network Speed Test" -unpin
# Pin-App "Skype" -unpin
# Pin-App "Remote Desktop" -unpin
# Pin-App "Microsoft News" -unpin
# Pin-App "Groove Music" -unpin
# Pin-App "Calculator" -unpin
# Pin-App "Maps" -unpin
# Pin-App "Microsoft Whiteboard" -unpin
# Pin-App "Microsoft To-Do" -unpin
# Pin-App "Office Lens" -unpin
# Pin-App "Sway" -unpin
# Pin-App "Alarms & Clock" -unpin
# Pin-App "Voice Recorder" -unpin
# Pin-App "Weather" -unpin


# Get-AppxPackage -AllUsers| Foreach {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
Get-AppXProvisionedPackage -online | Remove-AppxProvisionedPackage -online

(New-Object -Com Shell.Application).
    NameSpace('shell:::{4234d49b-0245-4df3-b780-3893943456e1}').
    Items() |
  %{ $_.Verbs() } |
  ?{$_.Name -match 'Un&pin from Start'} |
  %{$_.DoIt()}

#   cp C:\tmp\start-layout.xml C:\Users\Default\AppData\Local\Microsoft\Windows\Shell\LayoutModification.xml
# Import-StartLayout C:\tmp\start-layout.xml -mountpath c:\

# New-LocalUser -Name "nick" -NoPassword


# $RunOnceKey = HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce
# Set-ItemProperty -Path $RunOnceKey -Name "NextRun" -Value "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy Bypass -File c:\tmp\cleanup-windows.ps1"
Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\RunOnce -Name NextRun -Value "C:\Windows\System32\WindowsPowerShell\v1.0\Powershell.exe -executionpolicy Bypass -File c:\tmp\cleanup-windows.ps1"

# use small taskbar icons
## cmd /c REG ADD HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V TaskbarSmallIcons /T REG_DWORD /D 1 /F
# Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Value TaskbarSmallIcons
cmd /c "REG ADD HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /V TaskbarSmallIcons /T REG_DWORD /D 1 /F"
Set-ItemProperty -path HKCU:\Software\Microsoft\Windows\Shell\Bags\1\Desktop -name IconSize -value 48
Stop-Process -name explorer  # explorer.exe restarts automatically after stopping
# taskkill /f /im explorer.exe
# start explorer.exe