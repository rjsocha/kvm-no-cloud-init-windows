@echo off
reg import clear-swap.reg
powershell Rename-Computer -NewName TEMPLATE -Force
del result.txt
c:\windows\system32\sysprep\sysprep /generalize /shutdown /oobe /mode:vm /unattend:C:\Windows\setup\scripts\unattend.xml
