set PROJ=DecHex
javac -classpath %JUMPCLASSPATH% *.java
pilrc -R %PROJ%.res %PROJ%.rcp
java -classpath %JUMPCLASSPATH%;.;%CLASSPATH% Jump -m %1 %2 %3 %4 %PROJ%
pila %PROJ%.asm
@echo off
if "%1" == "-" goto exit
del *.bin
del *.res
del *.class
del *.asm
:exit

