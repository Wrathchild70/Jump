@echo off

rem please note that theres an option (/!) at the Warp and Exegen command lines to not create the warp files
rem note also that all environment variables can be set in the dos prompt so you dont need to change each make.bat file. they are only set to default if not yet defined.

rem ///////////////// Environment Variables /////////////////
rem global vars - you must set up those environment variables so this bat file can run

echo TO FORCE A RECOMPILATION OF THE SOURCE FILES, PASS compile AS THE FIRST PARAMETER

if not "%swjvmpath%"=="" goto jvmok
rem try to find the jdk's

echo Searching for Jdk 1.3 ...
set swjvmpath=\java1.3
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\java13
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk1.3
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk13
if exist %swjvmpath%\bin\javac.exe goto jvmok

echo Jdk 1.3 not found. Searching for Jdk 1.2.2 ...
set swjvmpath=\java1.2.2
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\java122
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk1.2.2
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk122
if exist %swjvmpath%\bin\javac.exe goto jvmok

echo Jdk 1.2.2 not found. Searching for Jdk 1.1.8 ...
set swjvmpath=\java1.1.8
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\java118
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk1.1.8
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk118
if exist %swjvmpath%\bin\javac.exe goto jvmok

echo Jdk 1.1.8 not found. Searching for Jdk 1.1.7 ...
set swjvmpath=\java1.1.7
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\java117
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk1.1.7
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk117
if exist %swjvmpath%\bin\javac.exe goto jvmok

echo Jdk 1.1.7 not found. Searching for Jdk 1.1.5 ...
set swjvmpath=\java1.1.5
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\java115
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk1.1.5
if exist %swjvmpath%\bin\javac.exe goto jvmok
set swjvmpath=\jdk115
if exist %swjvmpath%\bin\javac.exe goto jvmok

echo No jvm found! Where did you installed it???
goto jvm_error

:jvmok
if not "%swjarfile%"=="" goto jarfileok

rem search for the jar file

set swjarfile=%swjvmpath%\jre\lib\rt.jar
if exist %swjarfile% goto jarfileok
set swjarfile=%swjvmpath%\lib\rt.jar
if exist %swjarfile% goto jarfileok
set swjarfile=%swjvmpath%\lib\classes.zip
if exist %swjarfile% goto jarfileok

goto jar_error

:jarfileok

if "%swpath%"=="" set swpath=\
if not exist %swpath%utils\Exegen.class goto sw_error
rem if not exist %swpath%palm\ext\wextras\classes\extra\io\Storable.class goto wextra_error

rem //////////////////   local vars - leave them alone! :-)   /////////////////
set appName=SpeedTest

rem ////////////// Processing ///////////////
echo JVM Path: %swjvmpath%
echo JAR File: %swjarfile%
echo App name: %appName%
if not exist %appName%.class goto mustcompile
if not '%1'=='compile' goto warponly
:mustcompile
echo Running javac to compile %appName% classes...
%swjvmpath%\bin\javac -O -target 1.1 -classpath %swpath%lib\SuperWaba.jar;%swpath%palm\ext\xplat\wextras\classes;.;superwaba *.java superwaba/*.java superwaba/portable/*.java
if not "%errorlevel%"=="0" goto end
echo Compiled.

:warponly
%swjvmpath%\bin\java -classpath %swjarfile%;%swpath%utils;%swpath%lib\SuperWaba.jar;.;superwaba Warp c %appName% %appName%.class
if not errorlevel 0 goto end
%swjvmpath%\bin\java -classpath %swjarfile%;%swpath%utils;%swpath%lib\SuperWaba.jar;.;superwaba Exegen %appName% %appName% %appName%
if not errorlevel 0 goto end
echo:
dir *.p??
echo:
echo
goto end

rem ////////////// Error Handling //////////////
:wextra_error
echo You must build the wextras prior from building %appName%. goto \superwaba\ext\xplat\wextras and run the make.bat file.
goto end
:jar_error
echo This bat searches for the jar file where the java classes resides in all common locations, but could not find it (rt.jar or classes.zip). Please set the environment variable 'swjarfile' with the full path/filename to the jar file of the jdk you're using.
goto end
:sw_error
echo This bat assumes that SuperWaba is installed at \  . If its not, modify the swpath environment var to point to the correct location where \superwaba\... resides.
goto end
:jvm_error
echo This bat searches for the most common jdk's and their possible paths, but the jdk could not be located. Please set the environment variable 'swjvmpath' to the location where your jdk is (eg: \jdk1.2.2).
:end
set appName=
