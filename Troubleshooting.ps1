$checkaccount = get-localuser -Name "migo" | select-object FullName, Enabled, PasswordLastset

if($checkaccount.Enabled){

    write-host "Account is Enabled"

 } else { 

    write-host "Account is Disabled" -ForegroundColor green 

    Enable-LocalUser -Name "migo" -Confirm

    }

$layout = [PSCustomObject]@{

          FullName = $checkaccount.FullName

          Enabled = $checkaccount.Enabled

          PasswordLastSet = $checkaccount.Passwordlastset

          }

$layout | Format-List


$checkprocess = get-process | where-object {$_.CPU -gt 50 -and $_.WorkingSet -gt 100MB} | sort-object  Cpu -Descending | 

select-object CPU, WorkingSet, ID, Name

$getspace = Get-Volume

$serviceserror = get-service | where-object {$_.Status -eq "Stopped"} | select-object Name, status

$getuptime = Get-CimInstance win32_operatingsystem | select-object lastbootuptime


$layout2 = [PsCustomObject]@{

            Process = $checkprocess

            GetSpace = $getspace

            Service = $serviceserror

            UpTime = $getuptime

            }

$layout2 | Format-list 


Clear-DnsClientCache

write-host "Dns Cache Cleared"

$dns = Get-DnsClientCache

$resolve = Resolve-DnsName -name google.com

$ping = ping 8.8.8.8


$layout3 = [PSCustomObject]@{

            DNS = $dns

            ResolveTest = $resolve

            pingtest = $ping

            }
$layout3

