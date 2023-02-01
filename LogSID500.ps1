$cred = Get-Credential
$servers = Get-Content "C:\temp\servers.txt"
foreach ($server in $servers) {
    Write-Host "Checking server $server"
    $accounts = Get-WmiObject -Class Win32_UserAccount -ComputerName $server -Credential $cred
    foreach ($account in $accounts) {
        $username = $account.Name
        $sid = $account.SID
        $output = New-Object PSObject -Property @{
            Server = $server
            User = $username
            SID = $sid
        }
        $output | Export-Csv -Path "C:\temp\output.csv" -NoTypeInformation -Append
    }
}

#need to specify only SID 500