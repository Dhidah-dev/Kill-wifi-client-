@echo off 
set file_to_read=..\config.cfg 
set /a adr_path_gui=17
set /a adr_path_pack=19
set /A counter=1
setlocal ENABLEDELAYEDEXPANSION


for /f "delims=*" %%A  in (%file_to_read%) do (
		if !counter! equ !adr_path_gui! set ADR_GUI=%%A
		if !counter! equ !adr_path_pack! set ADR_PACK=%%A


	set /A counter=!counter!+1
		
)

REM cd %ADR_GUI%
REM call mvn clean 
REM call mvn validate 
REM call mvn compile 
REM call mvn assembly:single
REM call mvn package
REM call mvn install 
cd %ADR_PACK% 
mkdir %date:~-10,2%"-"%date:~7,2%"-"%date:~-4,4%
FOR /F "delims=" %%i IN ('dir /b /ad-h /t:c /od') DO SET a=%%i
xcopy ..\..\..\..\git\repo\gui\installer\target\SetupSTM32CubeProgrammer.zip ..\..\..\..\..\Users\dhidahr\Desktop\package\%a% /Y





