$account = read-host -Prompt "what account would you like to delete?"

$answer = read-host -Prompt "Are you sure u want to delete?"

if($answer -eq "yes"){

    Remove-LocalUser -name $account -Confirm

    write-host "Account '$account' Deleted"


} else { 

    write-host "Account Deletion Aborted."

}