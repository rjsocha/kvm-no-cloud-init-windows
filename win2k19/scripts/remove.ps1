$appsToRemove = @(
    "*Zune*"
    "*Xbox*"
    "*WindowsFeedback*"
    "*Wallet*"
    "*SkypeApp*"
    "*People*"
    "*OneConnect*"
    "*Office*"
    "*Messaging*"
    "*Weather*"
    "*windowscommunicationsapps*"
    "*Solitaire*"
    "*WindowsMaps*"
    "*WindowsCamera*"
    "*WindowsAlarms*"
    "*Print3D*"
    "*3DViewer*"
    "*GetStarted*"
    "*GetHelp*"
)
foreach ($app in $appsToRemove) {
    Get-AppxProvisionedPackage -Online | where {$_.PackageName -like $app} | Remove-AppxProvisionedPackage -Online -ErrorAction SilentlyContinue
}