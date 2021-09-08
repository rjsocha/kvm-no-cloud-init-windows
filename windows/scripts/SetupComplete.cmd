@echo off
cd C:\Windows\Setup\Scripts\
powershell -ExecutionPolicy bypass -File .\kvm-no-cloud-init.ps1 >result.txt
