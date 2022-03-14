#enumeration
$GetDate = Get-Date
$nl = [Environment]::NewLine
function Enumeration(){
    $filter = ('netstat -anob | Select-String -Pattern Established', 'netstat -anob | Select-String -Pattern Listening', 'Get-Process', 'Get-Service | findstr Running',"get-scheduledtask | findstr Ready", "get-scheduledtask | findstr Running",
                "get-addomain", "get-aduser -filter *", 
                "net user",'search-ADAccount -LockedOut',"Get-ADGroup -Filter *", "Get-ADComputer -filter *", 
                'Get-GPO -all | select DisplayName, gpostatus', 'get-executionpolicy', "rendom /list", "wmic qfe list brief",
                "wmic startup get caption,command,location", "ls 'C:\Program Files'", "ls 'C:\Program Files (x86)'",
                "wmic product get Caption,InstallDate,Vendor")
    foreach($x in $filter){
        PrintFormatting('1')
        PrintFormatting(-join 'Running',$x, $nl)
        PrintFormatting(Invoke-expression($x))
    }
}
function PrintFormatting($OtP){
    $loc = "$env:UserProfile\Desktop\Output.txt"
    if($otp -eq '1'){
        echo "##############################" >> $loc
        echo "$GetDate" >> $loc
    }
    else{
        echo $OtP >> $loc
        echo $nl >> $loc
    }
    #echo "##############################" >> $loc
}
Enumeration