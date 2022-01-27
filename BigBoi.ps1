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
	[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls, Ssl3"
	New-Item -Path $env:UserProfile\Desktop\SysinternalsSuite -ItemType Directory
	Invoke-WebRequest -Uri https://download.sysinternals.com/files/SysinternalsSuite.zip -Outfile $env:UserProfile\Desktop\SysinternalsSuite\SysinternalsSuite.zip
	PrintFormatting('SysinternalsSuite downloaded')
	Invoke-WebRequest -Uri https://download.mozilla.org/?product=firefox-stub"&"os=win"&"lang=en-US -Outfile $env:UserProfile\Desktop\firefox.exe
	PrintFormatting('Firefox downloaded')
	Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=839516 -Outfile $env:UserProfile\Desktop\wmf5.msu
	PrintFormatting('Windows Management Framework 5.1 downloaded')
	Invoke-WebRequest -Uri 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/PowerShell-7.2.1-win-x86.msi' -Outfile $env:UserProfile\Desktop\PowerShell.msi
	PrintFormatting('PowerShell-7 downloaded')
	Invoke-WebRequest -Uri 'https://nxlog.co/system/files/products/files/348/nxlog-ce-2.11.2190.msi' -Outfile $env:UserProfile\Desktop\nxlog.msi
	PrintFormatting('NXLog downloaded')
	Invoke-WebRequest -Uri https://github.com/ION28/BLUESPAWN/archive/refs/heads/master.zip -Outfile $env:UserProfile\Desktop\bluespawn.zip
	PrintFormatting('Bluespawn downloaded')
	wget -O splunkforwarder-8.2.4-87e2dda940d1-x64-release.msi 'https://download.splunk.com/products/universalforwarder/releases/8.2.4/windows/splunkforwarder-8.2.4-87e2dda940d1-x64-release.msi'
	PrintFormatting('Splunk forwarder downloaded')
	Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vc_redist.x86.exe' -Outfile $env:UserProfile\Desktop\msvcrd.exe
	PrintFormatting('C++ Redistributable downloaded')
	Invoke-WebRequest -Uri 'https://www.clamav.net/downloads/production/clamav-0.104.1.win.x64.msi' -Outfile $env:UserProfile\Desktop\vongole.msi
	PrintFormatting('ClamAV downloaded')
	PrintFormatting('1')
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
	$parttwo = ('"Block SMB"', '"Block RDP"', '"Block SSH"', '"Block VNC"')
	$partthree = ' -Direction Inbound -LocalPort ' 
	$partfour = ('445','3389','22','5300')
	$partfive = ' -Protocol TCP -Action Block'
	#could've just added the hards to the join
	#will be expanded
	$z=0
	$Final =@()
	foreach($y in $parttwo){
		$Final += ,-join ($partone,$y,$partthree,$partfour[$z],$partfive)
		$z++
	}
	$Finaltwo =@()
	$z=0
	foreach($y in $parttwo){
		$Finaltwo += ,-join ($partone,$y,"' -Direction Outbound -LocalPort '",$partfour[$z],$partfive)
		$z++
	}
	#for outbounds
	foreach($i in $final){
		invoke-expression($i)
	}
	
}
function Install(){
	start $env:UserProfile\Desktop\wmf5.msu
	start $env:UserProfile\Desktop\PowerShell.msi
	start $env:UserProfile\Desktop\msvcrd.exe
	start $env:UserProfilie\Desktop\vongole.msi
	# install forwarder manually due to competition env
}
#install things
function Clammy(){
	cd 'C:\Program Files\ClamAV'
	copy .\conf_examples\freshclam.conf.sample .\freshclam.conf
	copy .\conf_examples\clamd.conf.sample .\clamd.conf
	echo 'Remove #Example'
	write.exe .\freshclam.conf
	write.exe .\clamd.conf
	echo 'Run: .\clamscan.exe -recursive C:\'
	
}
#install ClamAV

#Initial firewall settings, to be modified as needed
function Injects(){
	#consider NTP, FTP, ETC
	#waste of time to script it/give away process
}
#Pull information and provide set up for common injects
function ServerOptions(){
	#not worth it most likely
}
#Options for Running on a server
function WorkstationOptions(){
	#As above
	#use Arg[] to execute certain functions ex script.sh 1 1 1 1
		#will run the first four functions
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
if($Arg[0] = 1){
	DL
}
if($Arg[1] = 1){
	Enumeration
}
if($Arg[2] = 1){
	FirewallInit
}
if($Arg[3] = 1){
	Install
}
if($Arg[4] = 1){
	Clammy
}