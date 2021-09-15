@echo off
rmdir /s /q \Windows\Panther\UnattendGC
rmdir /s /q \Windows\Panther\Unattend
rmdir /s /q \Windows\Panther\actionqueue
del /f /q \Windows\Panther\unattend.xml
del /f /q \Windows\Panther\setupinfo
del /f /q \Windows\Panther\setup.etl
del /f /q \Windows\Panther\*.que
del /f /q \Windows\Panther\*.log
del /f /q \Windows\Panther\Contents*