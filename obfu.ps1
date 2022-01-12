function Test(){

$f = '70 69 6E 67 20 38 2E 38 2E 38 2E 38', '4E 65 77 2D 49 74 65 6D 20 2D 50 61 74 68 20 24 65 6E 76 3A 55 73 65 72 50 72 6F 66 69 6C 65 5C 44 65 73 6B 74 6F 70 5C 53 79 73 69 6E 74 65 72 6E 61 6C 73 53 75 69 74 65 32 20 2D 49 74 65 6D 54 79 70 65 20 44 69 72 65 63 74 6F 72 79 0A 09 49 6E 76 6F 6B 65 2D 57 65 62 52 65 71 75 65 73 74 20 2D 55 72 69 20 68 74 74 70 73 3A 2F 2F 64 6F 77 6E 6C 6F 61 64 2E 73 79 73 69 6E 74 65 72 6E 61 6C 73 2E 63 6F 6D 2F 66 69 6C 65 73 2F 53 79 73 69 6E 74 65 72 6E 61 6C 73 53 75 69 74 65 2E 7A 69 70 20 2D 4F 75 74 66 69 6C 65 20 24 65 6E 76 3A 55 73 65 72 50 72 6F 66 69 6C 65 5C 44 65 73 6B 74 6F 70 5C 53 79 73 69 6E 74 65 72 6E 61 6C 73 53 75 69 74 65 32 5C 53 79 73 69 6E 74 65 72 6E 61 6C 73 53 75 69 74 65 2E 7A 69 70'

#invoke-expression code

foreach ($x in $f) {
Invoke-Expression ($frt = ($x -split ' ' | foreach-object {[char][byte]"0x$_"}) -join '')
}
<# $f[$x] array to hold the hex commands

#>

<# 
	Invoke-Expression ($frt = ($x -split ' ' | foreach-object {[char][byte]"0x$_"}) -join '')
	
   $f holds the hex command
   $frt holds the converted array of single characters
   -join '' combines the single char array into a string
   the whole thing is wrapped into the invoke-expression command
   
   
   
   backup
   invoke-expression ($frt = ($f -split ' ' | foreach-object {[char][byte]"0x$_"}) -join '')
   #>
}

Test