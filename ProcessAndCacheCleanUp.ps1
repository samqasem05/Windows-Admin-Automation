# This script will terminate any hanging oulook or teams processes or services running on this machine
# This script will also clean the cashe in C:\Users\j_miller\AppData\Local\Microsoft\Teams\Cache safley.

$processid = get-process | where-object {$_.Name -like "*outlook*" -or $_.name -like "*teams*"}

if($processid){

    stop-process -Id $processid -Force -ErrorAction SilentlyContinue
    write-host "Process cleaned" -ForegroundColor Green

    Start-Sleep -Seconds 2

} else { 

    write-host "No Process Found" -ForegroundColor Red

}

$PathTest = Test-Path -Path "C:\Users\j_miller\AppData\Local\Microsoft\Teams\Cache"

if($PathTest -eq $true){

    Remove-Item -Path "C:\Users\j_miller\AppData\Local\Microsoft\Teams\Cache" -Recurse -force
    Write-Host "Teams Cache Cleared sucessfully!" -ForegroundColor Green

} else { 

    write-host "No Directoy Found" -ForegroundColor red

    }

