###########################################################
### Powershell enumeration for Active Directory servers ###
### Author: Liam Powell 								###
### Contact: liam.powell@my.metrostate.edu              ###
###########################################################

### Global variable declaration ###

### Output Handling ###

#$OtP
#Output to Process
#$PO
#Processed Output

### Input Handling ###
#$EIn = '1'
#Expected Input Parameter

### Command variables ###
#$Sfts = shutdown.exe -f -s -t 00

### Program Start ###
#if($args[0] -ne $EIn ){
#	$Sfts
#}
$GetDate = Get-Date
$nl = [Environment]::NewLine

function DL(){
	New-Item -Path $env:UserProfile\Desktop\SysinternalsSuite -ItemType Directory
	Invoke-WebRequest -Uri https://download.sysinternals.com/files/SysinternalsSuite.zip -Outfile $env:UserProfile\Desktop\SysinternalsSuite\SysinternalsSuite.zip
	Invoke-WebRequest -Uri https://download.mozilla.org/?product=firefox-stub"&"os=win"&"lang=en-US -Outfile $env:UserProfile\Desktop\firefox.exe
	PrintFormatting('1')
	PrintFormatting('Sysinternals and Firefox downloaded')
}
#Downloads
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
#Format the output of the enumeration to be more readable
function Enumeration(){
	<# make array of enum commands 
		cycle through them
		apply a[x] = $var
		pass $var to PrintFormatting
		


"get-aduser -filter * -Properties Name, PasswordNeverExpires | where {$_.passwordNeverExpires -eq True} | Select-Object DistinguishedName, Name, Enabled"#>
	$filter = ('netstat -ano | Select-String -Pattern Established', 'Get-Process', 'Get-Service | findstr Running', "get-addomain", "get-aduser -filter *", 
				'search-ADAccount -LockedOut',"Get-ADGroup -Filter *", "Get-ADComputer -filter *", 
				'Get-GPO -all | select DisplayName, gpostatus', 'get-executionpolicy', "rendom /list")
	foreach($x in $filter){
        PrintFormatting('1')
        PrintFormatting(-join 'Running',$x, $nl)
		PrintFormatting(Invoke-expression($x))
	}
}
#Enumeration takes place here and is passed to the formatting function
function FirewallInit(){
	PrintFormatting('1')
	PrintFormatting('Enabled Firewall')
	$en = 'Set-NetFirewallProfile -Enabled True'
	PrintFormatting(invoke-Expression($en))
	$filter = ('get-netadapter', 'Get-NetFirewallRule | Select-Object DisplayName, Enabled, Direction, Action | Select-String -Pattern True')
	foreach($x in $filter){
	PrintFormatting(invoke-Expression($x))
	}
	$partone = 'New-Netfirewallrule -DisplayName '
	$parttwo = ('"Block SMB"', '"Block RDP"', '"Block SSH"')
	$partthree = ' -Direction Inbound -LocalPort ' 
	$partfour = ('445','3389','22')
	$partfive = ' -Protocol TCP -Action Block'
	$z=0
	$Final =@()
	foreach($y in $parttwo){
		$Final += ,-join ($partone,$y,$partthree,$partfour[$z],$partfive)
		$z++
	}
	foreach($i in $final){
		invoke-expression($i)
	}
	
}
#Initial firewall settings, to be modified as needed
function Injection(){
}
#Pull information and provide set up for common injects
function ServerOptions(){
}
#Options for Running on a server
function WorkstationOptions(){
}
#Options for running on a workstation
function Sniff(){
}
<#Examine potential threats
	Examine insecure accounts
		Flagged permissions
		Account activity
	Examine insecure groups
		Accounts that don't belong 
		Flagged permissions
		Auto flag admin permissions
	Examine GPO
		GPOs that affect passwords,
		Networking, Permissions,
		Connections, and Logins 
	Examine recently changed files
		Files within the core AD architecture
		Core windows files
		#>
###########################################################
### Outcomes
### Enumeration, Basic Firewalls, NO HARDENING, 
### Inject set up (No execution or finalization), environment set up, 
### Parse enumeration ouput for outliers and potential threats
###########################################################
DL
Enumeration
