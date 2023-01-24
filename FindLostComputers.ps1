#Get the names of computers that have no manager and no description
$computers = Get-ADComputer -Filter * -Property ManagedBy, Description | Where-Object { $_.ManagedBy -eq $null -and $_.Description -eq $null } | select-object -expandproperty name 

#create file name with date
$date = Get-Date -Format "MM-dd-yyyy"
$file = $PSScriptRoot + "\" + "$date" + ".csv"

#write computer names and ping results to array
$Output = foreach ($computer in $computers) {  

    #if ping is successful
    if (test-Connection -ComputerName $computer -Count 2 -Quiet ) {   
        New-Object -TypeName PSObject -Property @{
            Computer  = $computer
            Status    = "Online" 
            LastLogon = Get-ADComputer -Identity $computer -Properties Lastlogondate | Select-Object -ExpandProperty Lastlogondate
            IPv4      = Get-ADComputer -Identity $computer -Properties IPv4Address | Select-Object -ExpandProperty IPv4Address
            OS        = Get-ADComputer -Identity $computer -Properties OperatingSystem | Select-Object -ExpandProperty OperatingSystem
        } | Select-Object Computer, Status, LastLogOn, IPv4, OS
    } 

    #if ping is unsuccessful          
    else { 
        New-Object -TypeName PSObject -Property @{
            Computer  = $computer
            Status    = "Offline" 
            LastLogon = Get-ADComputer -Identity $computer -Properties Lastlogondate | Select-Object -ExpandProperty Lastlogondate
            IPv4      = Get-ADComputer -Identity $computer -Properties IPv4Address | Select-Object -ExpandProperty IPv4Address 
            OS        = Get-ADComputer -Identity $computer -Properties OperatingSystem | Select-Object -ExpandProperty OperatingSystem
        } | Select-Object Computer, Status, LastLogOn, IPv4, OS
    }      
          
} 

#Sort array by ping results
$Output = $Output | Sort-Object Status, LastLogon

#export array to csv
$Output | export-csv -Path $file -NoTypeInformation