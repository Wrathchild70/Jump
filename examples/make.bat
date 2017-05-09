@echo off
cd DecHex
call make %1 %2 %3
cd ..\Hello
call make %1 %2 %3
cd ..\Life
call make %1 %2 %3
cd ..\MenuExample
call make %1 %2 %3
cd ..\Morse
call make %1 %2 %3
cd ..\SpeedTest
call make %1 %2 %3
cd ..
