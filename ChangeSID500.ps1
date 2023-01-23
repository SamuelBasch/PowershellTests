$accounts = Get-WmiObject -Class Win32_UserAccount
foreach ($account in $accounts) {
    if ($account.SID -like "*-500") {
        $username = $account.Name
        Write-Host "SID ending in 500: $username"
        $yesno = Read-Host "Do you want to rename this account to ADMINUSER? (y/n)"
        if ($yesno -eq "y") {
            $account.Rename("ADMINUSER")
            Write-Host "Account renamed to ADMINUSER"
        }
    } else {
        $username = $account.Name
        Write-Host "Other SID: $username"
    }
}
