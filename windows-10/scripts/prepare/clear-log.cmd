@echo off
rem powershell -ExecutionPolicy bypass -File .\clear-log.ps1
for /F "tokens=*" %%1 in ('wevtutil.exe el') DO wevtutil.exe cl "%%1"
