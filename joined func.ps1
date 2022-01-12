function FirewallInit(){
	#PrintFormatting('1')
#	PrintFormatting('Enabled Firewall')
	#$en = 'Set-NetFirewallProfile -Enabled True'
	#PrintFormatting(invoke-Expression($en))
	#$filter = ('get-netadapter', 'Get-NetFirewallRule | Select-Object DisplayName, Enabled, Direction, Action | Select-String -Pattern True',)
#	foreach($x in $filter){
	#PrintFormatting(invoke-Expression($x))
	#}
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
		echo $i
	}
	
}
FirewallInit