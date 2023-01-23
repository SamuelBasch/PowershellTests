$accounts = Get-WmiObject -Class Win32_UserAccount
foreach ($account in $accounts) {
    if ($account.SID -like "*-500") {
        $username = $account.Name
        Write-Host "SID ending in 500: $username"
    } else {
        $username = $account.Name
        Write-Host "Other SID: $username"
    }
}
