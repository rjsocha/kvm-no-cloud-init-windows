$kvm_oem = "/windows/setup/scripts/tool/smbios-oem-strings.exe"
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
foreach($e in $cnf) {
        $opts=$e.Split('!')
        foreach($entry in $opts) {
                switch -Regex ($entry) {
                        '^name:' {
				$_name=$entry.substring('name:'.length)
                        }
                }
        }
}
if ( $_name.Length -gt 0 ) {
	echo "Rename computer to $_name (unattended hack)"
	Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\UnattendSettings\Microsoft-Windows-Shell-Setup" -Name ComputerName -Value $_name
}
New-Item -Path "\Windows\Panther\" -Name "unattend" -ItemType Directory -Force -ErrorAction SilentlyContinue | Out-Null
Copy-Item "\Windows\setup\scripts\rskvm.xml" -Destination "\windows\panther\unattend\unattend.xml" -Force | Out-Null
