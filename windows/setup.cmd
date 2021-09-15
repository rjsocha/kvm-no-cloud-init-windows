@echo off
if exist c:\windows\setup\scripts\nul rmdir /s /q c:\windows\setup\scripts
xcopy /y /e scripts c:\windows\setup\scripts\
