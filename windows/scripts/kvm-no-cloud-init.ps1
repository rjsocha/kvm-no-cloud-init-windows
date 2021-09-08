$kvm_oem = "./smbios-oem-strings.exe"
function _get_config {
        $count = & $kvm_oem "count"
        $cnf = @()
        if( $count -gt 0 ) {
                for($i=0; $i -lt $count; $i++) {
                        $_config=& $kvm_oem $i
                        if ($_config -match '^kvm-cnf-net!' -Or $_config -match '^kvm-cnf-no-net!') {
                                $cnf += $_config
                        }
                }
        }
        $cnf
}

$cnf = _get_config
$_name=""
$_dns_registry=""
foreach($e in $cnf) {
        $opts=$e.Split('!')
        foreach($entry in $opts) {
                switch -Regex ($entry) {
                        '^win-user:' {
				Remove-LocalUser -Name root -ErrorAction SilentlyContinue | Out-Null
				$_ui=$entry.substring('win-user:'.length)
				$_user=$_ui.Split('@')
				$_p = $_user[1] | ConvertTo-SecureString -AsPlainText -Force
				New-LocalUser  -Name $_user[0] -Password $_p
				Add-LocalGroupMember -Member $_user[0] -Group Administrators
			}
                        '^name:' {
				$_name=$entry.substring('name:'.length)
                        }
                        '^dns-registry:' {
                                $_dns_registry="$($entry.substring('dns-registry:'.length))"
                        }
                }
        }
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" -Name ClearPageFileAtShutdown -Value 0
New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Network\NewNetworkWindowOff" -Force | Out-Null
reg.exe import enable-pagefile.reg
if ( $_name.Length -gt 0 ) {
	echo "Rename computer to $_name"
	Rename-Computer -NewName $_name -Force
	if ( $_dns_registry.Length -gt 0) {
		echo "Register name in DNS"
		do {
			$cnt++
			try {
				Invoke-WebRequest -UseBasicParsing http://$_dns_registry/$_name
				break
			} catch {
				echo "Retry DNS registration $cnt"
				Start-Sleep -Milliseconds 250
			}
		} while ($cnt -lt 21)
	}
	# not recommended...
	# Restart-Computer -Force
	shutdown.exe /f /t 60 /r
}