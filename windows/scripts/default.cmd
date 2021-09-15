@echo off
reg import clear-swap.reg
del result.txt
c:\windows\system32\sysprep\sysprep /generalize /shutdown /oobe /mode:vm /unattend:C:\Windows\setup\scripts\default.xml
