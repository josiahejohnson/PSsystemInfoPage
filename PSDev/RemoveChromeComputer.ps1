# This script checks for Chrome Enterprise and or software policies in registry. If present Chrome will then uninstall and or remove. Script then installs fresh Chrome Enterprise msi. Chrome Software Polices will be managed via GPO. 

$ChromeUinstall = "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{1B729E3D-B16D-3A41-A9AE-6AEC20C6580D}"
$ChromePol = "hklm:\Software\Policies\Google"

#test for Registry Policy, then remove if present
if (!(Test-Path -Path $ChromePol))
{
    return
    }
    else
    {
    Remove-Item -path $ChromePolRem -Recurse -force
    }
# Install Google Chrome Enterprise

if (!(Test-Path -Path $ChromeUinstall))
{
    Invoke-Expression "msiexec /qn /i \\zen10\apps\MSI\GoogleChrome\GoogleChromeStandaloneEnterprise.msi"
    while($ture)
{
if(Get-Process msiexec -ea 0)
{
sleep 1
}
else
{
return
}
}
}
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Restricted -force
exit
