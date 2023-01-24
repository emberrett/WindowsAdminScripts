$file = $ScriptRoot + "\" + "output.log"
$x = Get-ADComputer -Properties memberof -Filter { OperatingSystem -Like "*7*" }
$z = 0
foreach ($y in $x){
$z+= 1
}

Write-Output $z
Read-Host "Press Enter to exit"
*> $file