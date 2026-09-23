$computerName = $env:COMPUTERNAME

$CurrentUser = $env:USERNAME



$WindowsCurrentVersion = Get-CimInstance win32_operatingsystem | 

select-object buildnumber, version

$systemuptime = (Get-CimInstance win32_operatingsystem).LastBootUpTime



$CPUutilization = (get-ciminstance win32_process).loadPercentage

$memoryusage = (Get-CimInstance win32_computersystem).TotalPhysicalMemory /1gb | 

select-object TotalPhysicalmemory

$TopMemory = get-process | 

select-object workingset64, name -First 10

$freediskspace = (Get-psdrive C).Free /1gb

$useddiskspace = (Get-PSDrive C).Used /1gb



$NetworkAdapters = get-netadapter | 

select-object name, status -ErrorAction SilentlyContinue

$IPV4 = Get-NetIPConfiguration | 

where-object {$_.interfacealias -like "Wi-Fi"} | 

select-object ipv4address, interfacealias -ErrorAction SilentlyContinue

$Prefix = Get-NetIPAddress | 

where-object {$_.InterfaceAlias -like "Wi-Fi"} | 

select-object prefixlength, interfacealias, ipaddress -ErrorAction SilentlyContinue

$gateway = Get-NetIPconfiguration | 

Where-Object {$_.InterfaceAlias -like "Wi-Fi"} | 

select-object ipv4defaultgateway -ErrorAction SilentlyContinue

$dnsservers = Get-NetIPConfiguration |

where-object {$_.interfacealias -like "Wi-Fi"} |

select-object DNsServer, interfacealias -ErrorAction SilentlyContinue

$DHcp = Get-Service -name Dhcp |

select-object servicename, status



$DNSTEST = Resolve-DnsName google.com |

select-object ipv4address, name, ttl, type, section, address

$GATEWAYTEST = Test-netConnection $gateway |

select-object tcptestsucceeded

$INTERNETTEST = Test-NetConnection | 

select-object pingsucceeded, pingreplydetailes



$WindowsServices = Get-Service | 

where-object {$_.Status -like "Running"} | 

select-object servicename, status -First 20



$RECENTSYSTEMERRORS = Get-WinEvent -LogName system |

Where-Object {$_.leveldisplayname -like "error"} | 

select-object timecreated, id, leveldisplayname -First 50

$RECENTAPPERRORS = Get-WinEvent application | 

where-object {$_.leveldisplayname -like "error"} | 

Select-Object id, timecreated, leveldisplayname


$layout = [PSCustomObject]@{

          COMPUTERNAME = $computerName
          USERNAME = $CurrentUser
          WINDOWSVERSION = $WindowsCurrentVersion
          SYSTEMUPTIME = $systemuptime
          CPUUTILIZATION = $CPUutilization
          MEMORYUSAGE = $memoryusage
          TOPMEMORY = $TopMemory
          FREEDISK = $freediskspace
          USEDDISK = $useddiskspace
          NETWORKADAPTER = $NetworkAdapters
          IPV4 = $IPV4
          PREFIX = $Prefix
          GATEWAY = $gateway
          DNSSERVERS = $dnsservers
          DHCP = $DHcp
          DNSTEST = $DNSTEST
          GATEWAYTEST = $GATEWAYTEST
          INTERNETTEST = $INTERNETTEST
          WINDOWSSERVICES = $WindowsServices
          RECENTSYSERRORS = $RECENTSYSTEMERRORS
          RECENTAPPERRORS = $RECENTAPPERRORS

}

$layout | Out-String -Stream
