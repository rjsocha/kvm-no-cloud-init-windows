Get-ChildItem -Path "C:\Windows\Web" -File -Recurse | ForEach-Object { 
  	$acl = get-acl $_.FullName
	$a = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrator","FullControl","Allow")
	$acl.AddAccessRule($a)
	$acl | Set-Acl $_.FullName
}

Get-ChildItem -Path "C:\Windows\web" -File -Recurse | ForEach-Object {
	copy  C:\Windows\setup\scripts\bg\bg.jpg $_.FullName 
}

Get-ChildItem -Path "C:\Windows\web" -File -Recurse | ForEach-Object { 
	$acl = get-acl $_.FullName
	$a = New-Object System.Security.AccessControl.FileSystemAccessRule("Administrator","FullControl","Allow")
	$acl.RemoveAccessRule($a)
	$acl | Set-Acl $_.FullName
}
