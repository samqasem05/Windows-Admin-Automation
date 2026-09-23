$policy = $(get-executionpolicy)

if($policy -eq "RemoteSigned"){
    
    write-host
    
        $policy

} else {

    write-host

        "meh"

}

$service = $(get-service -Name DiagTrack)

$iguess = [PSCustomObject]@{

Name = $service.Name

Status = $service.Status

}

$iguess | ConvertTo-Json

if($service.Status -eq "Running"){

    write-host "its running as u can see bruh"

} else {

    write-host "oh..."

}

