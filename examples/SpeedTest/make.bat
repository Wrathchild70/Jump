@echo off
set PROJ=SpeedTest
if "%1" == "-O" goto jopt
javac -g:none -classpath %JUMPCLASSPATH% *.java jump/*.java jump/portable/*.java
if not errorlevel 0 goto exit
goto compiled
:jopt
shift
javac -O -g:none -classpath %JUMPCLASSPATH% *.java jump/*.java jump/portable/*.java
if not errorlevel 0 goto exit
:compiled
pilrc -R %PROJ%.res %PROJ%.rcp
java -classpath .;%JUMPCLASSPATH%;jump;%CLASSPATH% Jump -hw %1 %2 %3 %4 %PROJ%
if not errorlevel 1 goto ok
echo -------------------- Jump reported an error --------------------
goto cleanup
:ok
pila %PROJ%.asm
@echo off
:cleanup
if "%1" == "-" goto exit
del *.bin
del *.res
del *.class
del jump\*.class
del jump\portable\*.class
del %PROJ%.asm
:exit

