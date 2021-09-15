@echo off
powershell -ExecutionPolicy bypass -File \windows\setup\scripts\kvm-no-cloud-early.ps1
exit %errorlevel%