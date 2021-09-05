@echo off
reg import clear-swap.reg
reg import skip-rearm.reg
c:\windows\system32\sysprep\sysprep /generalize /shutdown /oobe /mode:vm /unattend:C:\Windows\vm-setup\unattend.xml
