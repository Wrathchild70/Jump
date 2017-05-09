@echo off
set PROJ=Life
if "%1" == "-O" goto jopt
javac -g:none -classpath %JUMPCLASSPATH% *.java
if not errorlevel 0 goto exit
goto compiled
:jopt
shift
javac -O -g:none -classpath %JUMPCLASSPATH% *.java
if not errorlevel 0 goto exit
:compiled
pilrc -R %PROJ%.res %PROJ%.rcp
java -classpath .;%JUMPCLASSPATH%;jump;%CLASSPATH% Jump -G %1 %2 %3 %4 %PROJ%
if not errorlevel 0 goto exit
m68k-palmos-gcc -c -Wa,-I..\..\jar %PROJ%.s
m68k-palmos-gcc -nostdlib -o %PROJ% %PROJ%.o
build-prc -o %PROJ%.prc -n %PROJ% -c Life -v 1.0 %PROJ% *.bin
@echo off
if "%1" == "-" goto exit
del *.bin
del *.res
del *.class
rem del %PROJ%.s
:exit

