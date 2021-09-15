@echo off
cd \Windows\Setup\Scripts\
powershell -ExecutionPolicy bypass -File .\kvm-no-cloud-config.ps1 >result.txt
