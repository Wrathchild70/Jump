rem --- build palmos and symbol classes and native-*.asm files
javac -O tools/*.java
java tools/MkApi >nul
java tools/MkApi -a tools/symbol.api -c Symbol -o native-symbol.asm >nul
java tools/MkApi -a tools/sony.api -c Sony -o native-sony.asm >nul

rem --- compile classes
javac -O *.java palmos/*.java java/lang/*.java

rem --- generate javadoc documentation for JUMP ---
javadoc -sourcepath . -private -windowtitle Jump2 -d ..\javadocs palmos
javadoc -private -windowtitle Jump2-Source -d ..\src_docs tools *.java 

rem --- generate the complete jarfile for JUMP ---
jar cvf ..\jar\jump.jar *.class *.asm *.properties java\lang\*.class palmos\*.class tools\*.class

rem --- generate the full ZIP file for JUMP ---
cd ..
jar cvMf dist\jump%1.zip jar doc examples javadocs src_docs NewSource\*.bat NewSource\*.java NewSource\*.properties NewSource\*.asm NewSource\java\lang\*.java NewSource\palmos\*.java NewSource\tools\*.java NewSource\tools\*.api
cd NewSource

rem --- generate the user ZIP file for JUMP ---
cd ..
jar cvMf dist\jump_user.zip jar doc examples javadocs
cd NewSource

