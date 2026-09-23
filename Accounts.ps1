$accountname = read-host -Prompt "whats the account name?"

$accountfullname = Read-Host -Prompt "whats ur full name?"

$accountpass = read-host -Prompt "whats ur pass?" -AsSecureString

$name = $accountname

$Accountcreation = New-LocalUser -Name $name -AccountNeverExpires -FullName $accountfullname -Password $accountpass

$accounts = read-host "would u like to see current accounts?"

if ($accounts -eq "yes"){
    write-host "fetching accounts..." 
    Get-LocalUser

} else {


    write-host "Thanks!"
    }
