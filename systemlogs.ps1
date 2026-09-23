#this script will fix any windows crashes or gpu issues

#we will fetch event logs related to only system performance

#we will then give a lyout of final 24 hours ina nice way telling us whats going on

$logs = Get-WinEvent -FilterHashtable @{logname='system'; starttime=(Get-Date).adddays(-1)}

foreach($log in $logs){

    $info = $log.Message

    $ID = $log.Id

    $process = $log.ProcessId

    $processdetail = Get-Process -Id $process -ErrorAction SilentlyContinue


        if ($log.LevelDisplayName -like "*Warning*"){

            
            $layout = [PSCustomObject]@{

                      Name = $log.Message

                      process = $log.ProcessId

                      Info = $log.LevelDisplayName

                }

                      $layout | ConvertTo-Json

                }
            }

               
                
    
   