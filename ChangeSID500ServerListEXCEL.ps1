$servers = Get-Content "C:\temp\servers.txt"
$output = @()
foreach ($server in $servers) {
    Write-Host "Checking server $server"
    $accounts = Get-WmiObject -Class Win32_UserAccount -ComputerName $server
    foreach ($account in $accounts) {
        if ($account.SID -like "*-500") {
            $username = $account.Name
            Write-Host "SID ending in 500: $username"
            $yesno = Read-Host "Do you want to rename this account to ADMINUSER? (y/n)"
            if ($yesno -eq "y") {
                $account.Rename("ADMINUSER")
                $status = "Renamed to ADMINUSER"
            }
            else {
                $status = "Not Renamed"
            }
        } else {
            $username = $account.Name
            $status = "Not SID ending in 500"
        }
        $output += New-Object PSObject -Property @{
            Server = $server
            User = $username
            Status = $status
        }
    }
}
$output | Export-Csv -Path "C:\temp\output.csv" -NoTypeInformation
