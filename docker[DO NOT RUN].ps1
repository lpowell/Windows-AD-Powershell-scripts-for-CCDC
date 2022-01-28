#################
# Docker 		#
# Enum&Firewall #
# Service&Proc	#
# Stopper		#
#################
$GetDate = Get-Date
$nl = [Environment]::NewLine

function DL(){
    PrintFormatting('1')
	[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls, Ssl3"
	New-Item -Path $env:UserProfile\Desktop\SysinternalsSuite -ItemType Directory
	Invoke-WebRequest -Uri https://download.sysinternals.com/files/SysinternalsSuite.zip -Outfile $env:UserProfile\Desktop\SysinternalsSuite\SysinternalsSuite.zip
	PrintFormatting('SysinternalsSuite downloaded')
    echo 'SysinternalsSuite downloaded'
	Invoke-WebRequest -Uri https://download.mozilla.org/?product=firefox-stub"&"os=win"&"lang=en-US -Outfile $env:UserProfile\Desktop\firefox.exe
	PrintFormatting('Firefox downloaded')
    echo 'Firefox downloaded'
	Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=839516 -Outfile $env:UserProfile\Desktop\wmf5r28.msu
	Invoke-WebRequest -Uri https://go.microsoft.com/fwlink/?linkid=839513 -Outfile $env:UserProfile\Desktop\wmf5.msu
	PrintFormatting('Windows Management Framework 5.1 downloaded')
    echo 'Windows Management Framework 5.1 downloaded'
	Invoke-WebRequest -Uri 'https://github.com/PowerShell/PowerShell/releases/download/v7.2.1/PowerShell-7.2.1-win-x86.msi' -Outfile $env:UserProfile\Desktop\PowerShell.msi
	PrintFormatting('PowerShell-7 downloaded')
    echo 'PowerShell 7 downloaded'
	#Invoke-WebRequest -Uri 'https://nxlog.co/system/files/products/files/348/nxlog-ce-2.11.2190.msi' -Outfile $env:UserProfile\Desktop\nxlog.msi
	#PrintFormatting('NXLog downloaded')
    #echo 'NXLog downloaded'
	Invoke-WebRequest -Uri https://github.com/ION28/BLUESPAWN/archive/refs/heads/master.zip -Outfile $env:UserProfile\Desktop\bluespawn.zip
	PrintFormatting('Bluespawn downloaded')
    echo 'Bluespawn Downloaded'
	Invoke-WebRequest -Uri 'https://download.splunk.com/products/universalforwarder/releases/8.2.4/windows/splunkforwarder-8.2.4-87e2dda940d1-x64-release.msi' -Outfile $env:UserProfile\Desktop\Splunk.msi
	PrintFormatting('Splunk forwarder downloaded')
    echo 'Splunk forwarder downloaded'
	Invoke-WebRequest -Uri 'https://aka.ms/vs/17/release/vc_redist.x86.exe' -Outfile $env:UserProfile\Desktop\msvcrd.exe
	PrintFormatting('C++ Redistributable downloaded')
    echo 'C++ Redistributable downloaded'
	Invoke-WebRequest -Uri 'https://www.clamav.net/downloads/production/clamav-0.104.1.win.x64.msi' -Outfile $env:UserProfile\Desktop\vongole.msi
	PrintFormatting('ClamAV downloaded')
    echo 'ClamAV downloaded'
	#Invoke-WebRequest -Uri 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2017/03/windows8-rt-kb4012217-x64_96635071602f71b4fb2f1a202e99a5e21870bc93.msu' -Outfile $env:UserProfile\Desktop\eb.msu
	#Invoke-WebRequest -Uri 'http://download.windowsupdate.com/d/msdownload/update/software/secu/2017/03/windows8.1-kb4012216-x64_cd5e0a62e602176f0078778548796e2d47cfa15b.msu' -Outfile $env:UserProfilie\Desktop\ebr28.msu
	#PrintFormatting('Eternal Blue Patch downloaded')
    #echo 'Eternal Blue Patch downloaded'
	Invoke-WebRequest -Uri 'https://gist.github.com/mubix/fd0c89ec021f70023695/archive/02e3f0df13aa86da41f1587ad798ad3c5e7b3711.zip' -Outfile $env:UserProfile\Desktop\krbtgtkeyreset.zip
	PrintFormatting('KRBTGT Reset script downloaded')
    echo 'KRBTGT Reset script downloaded'
	PrintFormatting('1')
}
function ServiceStopper(){
	PrintFormatting('1')
	PrintFormatting('ServiceStopper')
	$success =@()
	$fail =@()
	$test =@("ADWS","BFE","BrokerInfrastructure","CertPropSvc","CryptSvc","DcomLaunch","Dfs","DFSR","Dhcp","DNS","Dnscache","DPS","EventLog","EventSystem","FontCache","gpsvc","iphlpsvc","IsmServ",
			 "Kdc","LanmanServer","lmhosts","LSM","MpsSvc","MSDTC","Netlogon","netprofm","NlaSvc","nsi","NTDS","PlugPlay","PolicyAgent","Power","ProfSvc","RpcEptMapper",
			 "RpcSs","SamSs","Schedule","SENS","SessionEnv","ShellHWDetection","Themes","UALSVC","vds","W32Time","WinHttpAutoProxySvc","Winmgmt","WLMS")
	$service = (get-service | select-object Name | foreach { $_.Name -as [string]})
	foreach($x in $service){
		$z=0
		foreach($y in $test){
			if($x -ne $y){
				$z++
			}
		}
		if($z -eq 4){
			Try{
				set-service -Name $x -Status stopped -StartupType disabled -ErrorAction stop
				$success += $x
			}
			Catch{
				$fail += $x
				echo $x
			}
		}
	}
	PrintFormatting('Succesfully closed:')
	foreach($xx in $success){
		PrintFormatting($xx)
	}
	PrintFormatting('Failed to close:')
	foreach($yy in $fail){
		PrintFormatting($yy)
	}
}
function ProcessStopper(){
	PrintFormatting('1')
	PrintFormatting('Process Stopper')
	$success =@()
	$fail =@()
	$test =@("conhost","csrss","dfsrs","dfssvc","dns","dwm","explorer","Idle","iexplore","lsass","Microsoft.ActiveDirectory.WebServices","mmc",
			 "msdtc","notepad","powershell","ServerManger","services","smss","spoolsy","svchost","System","taskhostex","vds","wininit","winlogin","wlms","WmiPrvSE")
	$service = (get-process | select-object Name | foreach { $_.Name -as [string]})
	foreach($x in $service){
		$z=0
		foreach($y in $test){
			if($x -eq $y){
				$z++
			}
		}
		if($z -eq 4){
			Try{
				stop-process -Name $x -ErrorAction stop
				$success += $x
			}
			Catch{
				$fail += $x
				echo $x
			}
		}
	}
	PrintFormatting('Succesfully closed:')
	foreach($xx in $success){
		PrintFormatting($xx)
	}
	PrintFormatting('Failed to close:')
	foreach($yy in $fail){
		PrintFormatting($yy)
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
    (New-Object -ComObject HNetCfg.FwPolicy2).RestoreLocalFirewallDefaults()
    PrintFormatting('1')
    PrintFormatting('Reset firewall to installation defaults')
	$partone = 'New-Netfirewallrule -DisplayName '
	$parttwo = ('"Block SMB"', '"Block RDP"', '"Block SSH"', '"Block VNC"','"Range Block 1-52"','"Range Block 53-79"','"Range Block 81-87"','"Range Block 89-388"','"Range Block 390-442"','"Range Block 444-463"','"465-8079"','"Range Block 8081-49151"')
    #must keep 49152-65535 open according to ms
	$partthree = ' -Direction Inbound -LocalPort ' 
	$partfour = ('445','3389','22','5300','1-52','54-79','81-87','89-388','390-442','444-463','465-8079','8081-49151')
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
	foreach($yy in $parttwo){
		$Finaltwo += ,-join ($partone,$yy,' -Direction Outbound -LocalPort ',$partfour[$z],$partfive)
		$z++
	}
	#for outbounds
    PrintFormatting('1')
    PrintFormatting('Created BLOCK Rules')
	foreach($i in $final){
		invoke-expression($i)
        PrintFormatting($i)
	}
	foreach($d in $Finaltwo){
		invoke-Expression($d)
        PrintFormatting($d)
	}
	
	#enables
	$enablenames = ('"Allow DNS"','"Allow HTTP"', '"Allow LDAP 389"', '"Allow HTTPS"', '"Allow Splunk"','"Allow Kerberos 88 & 464"' )
	$enableports = ('53','80','389','443','8089','88,464')
	$enabler =@()
	$z=0
	foreach($w in $enablenames){
		$enabler += ,-join ('New-NetFirewallRule -DisplayName ',$w,' -Direction Inbound -LocalPort ',$enableports[$z],' -Protocol TCP -Action Allow')
		$z++
	}
	$enablertwo =@()
    $z=0
	foreach($v in $enablenames){
		$enablertwo +=,-join ('New-NetFirewallRule -DisplayName ',$v,' -Direction Outbound -LocalPort ',$enableports[$z],' -Protocol TCP -Action Allow')
	    $z++
    }
    PrintFormatting('1')
    PrintFormatting('Created ALLOW rules')
	foreach($zz in $enabler){
		invoke-Expression($zz)
        PrintFormatting($zz)
	}
	foreach($xx in $enablertwo){
		invoke-expression($xx)
        PrintFormatting($xx)
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
ProcessStopper