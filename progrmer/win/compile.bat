:@echo off
@echo on

set file_to_read=..\..\config.cfg 
set /a adr_file_manag_32=10
set /a adr_file_manag_64=12
set /a adr_path_gui=8
set /a adr_path_prog_32=18
set /a adr_path_prog_64=20
set /a set_path_32=3
set /a set_path_64=5
set /a adr_pack_creator_32=14
set /a adr_pack_creator_64=16
set /a adr_KeyGen_64=22
set /a adr_KeyGen_32=24
set /a adr_SigningTool_64=26
set /a adr_SigningTool_32=28
set /A counter=1
setlocal ENABLEDELAYEDEXPANSION


for /f "delims=*" %%A  in (%file_to_read%) do (
		if !counter! equ !set_path_32! set PATH_L_32=%%A
		if !counter! equ !set_path_64! set PATH_L_64=%%A
		if !counter! equ !adr_path_prog_32! set ADR_prog_32=%%A
		if !counter! equ !adr_path_prog_64! set ADR_prog_64=%%A
		if !counter! equ !adr_path_gui! set ADR_GUI=%%A
		if !counter! equ !adr_file_manag_32! set ADR_FILEMANGER_32=%%A
		if !counter! equ !adr_file_manag_64! set ADR_FILEMANGER_64=%%A
		if !counter! equ !adr_pack_creator_32! set ADR_packcreator_32=%%A
		if !counter! equ !adr_pack_creator_64! set ADR_packcreator_64=%%A
		if !counter! equ !adr_KeyGen_64! set ADR_KeyGen_64=%%A
		if !counter! equ !adr_KeyGen_32! set ADR_KeyGen_32=%%A
		if !counter! equ !adr_SigningTool_64! set ADR_SigningTool_64=%%A
		if !counter! equ !adr_SigningTool_32! set ADR_SigningTool_32=%%A

	set /A counter=!counter!+1
		
)


IF [%1]==[64] GOTO compile_64
IF [%1]==[32] GOTO compile_32
IF [%1]==[FileManager_32] GOTO compile_FileManager_32
IF [%1]==[FileManager_64] GOTO compile_FileManager_64
IF [%1]==[STM32TrustedPackageCreator_32] GOTO compile_STM32TrustedPackageCreator_32
IF [%1]==[STM32TrustedPackageCreator_64] GOTO compile_STM32TP_64a
IF [%1]==[KeyGen_64] GOTO compile_KeyGen_64
IF [%1]==[KeyGen_32] GOTO compile_KeyGen_32
IF [%1]==[SigningTool_64] GOTO compile_SigningTool_64
IF [%1]==[SigningTool_32] GOTO compile_SigningTool_32
IF [%1]==[""] (
	ECHO set parameter :  64 or 32 bit or FileManager_32 or FileManager_64 or STM32TrustedPackageCreator_64 or STM32TrustedPackageCreator_32
	goto END_PROG
)	ELSE (
	ECHO set parameter :  64 or 32 bit or FileManager_32 or FileManager_64 or STM32TrustedPackageCreator_64 or STM32TrustedPackageCreator_32
	goto END_PROG
)



:compile_32	
	path 
	Set PATH=%PATH%;%PATH_L_32%
	path
	cd %ADR_prog_32%	
	git pull origin develop 
	mingw32-make.exe clean
	del /s Makefile* 
	qmake
	mingw32-make.exe -j 8
	goto END_PROG

:compile_64 
    echo ##### Start Compiling STM32CubeProgrammer 64 bit #####
	path 
	Set PATH=%PATH%;%PATH_L_64%
	path
	cd %ADR_prog_64%
	git pull origin develop
	make clean 
	del /s Makefile*
	qmake
:	make -j 8
	cd sources
	qmake
	make clean
	make -f Makefile.Release -j 4
	cd ..\CubeProgrammer_API
	qmake
	make clean
	make -f Makefile.Release -j 4
	cd ..\app
	qmake
	make clean
	make -f Makefile.Release -j 4
	cd ..
	dir
	goto END_PROG
	
:compile_FileManager_32
	path 
	Set PATH=%PATH%;%PATH_L_32%
	path
	cd  %ADR_FILEMANGER_32%
	dir 
	git pull origin
:	git checkout 97e041f206bd1befeb21f9494be7c0af5a2e4ce7
:	mingw32-make.exe clean
	del /s .qmake.stash
	del /s Makefile* 
	cd ./release
	del /s /q .
	cd ..
	qmake
	mingw32-make.exe -f Makefile.Release -j 8
	goto END_PROG
	
	
	
:compile_FileManager_64
	path 
	Set PATH=%PATH%;%PATH_L_64%
	path
	cd  %ADR_FILEMANGER_64%
	dir 
	git pull origin develop
:	git checkout 97e041f206bd1befeb21f9494be7c0af5a2e4ce7
:	mingw32-make.exe clean
	del /s .qmake.stash
	del /s Makefile* 
	cd ./release
	del /s /q .
	cd ..
	qmake
	mingw32-make.exe -f Makefile.Release -j 8
	
	goto END_PROG
	
	

:compile_STM32TrustedPackageCreator_32
	path 
	Set PATH=%PATH%;%PATH_L_32%
	path
	cd  %ADR_packcreator_32%
	dir 
	git pull
 :   git checkout v1.0.0
	mingw32-make.exe clean
	del /s Makefile* 
	qmake
	mingw32-make.exe -j 8
	goto END_PROG
	
	
:compile_STM32TP_64a
	path 
	Set PATH=%PATH%;%PATH_L_64%
	path
	cd  %ADR_packcreator_64%
	git pull
:    git checkout v1.0.0
	cd preparation\release
	del /s /q .
	cd ..\
	del /s Makefile*
	qmake
	mingw32-make.exe -f Makefile.release -j 8
	cd ..\SFMIPreparationTool_CLI\release
	del /s /q .
	cd ..\
	del /s Makefile*
	qmake
	mingw32-make.exe -f Makefile.release -j 8
	cd ..\SFMIPreparationTool_GUI\release
	del /s /q .
	cd ..\
	del /s Makefile*
	qmake
	mingw32-make.exe -f Makefile.release -j 8
	goto END_PROG


:compile_KeyGen_64
	path
	Set PATH=%PATH%;%PATH_L_64%
	path
	cd  %ADR_KeyGen_64%
	git pull
	set OPENSSL_HOME=C:\Users\dhidahr\Desktop\sighning_tool\SigningTool\OpenSSL-Win32
	make clean
	del /s Makefile*
	qmake
	mingw32-make.exe -j 4
	goto END_PROG

:compile_KeyGen_32
	path
	Set PATH=%PATH%;%PATH_L_32%
	path
	cd  %ADR_KeyGen_32%
	git pull
	set OPENSSL_HOME=C:\Users\dhidahr\Desktop\sighning_tool\SigningTool\OpenSSL-Win32
	make clean
	del /s Makefile*
	qmake
	mingw32-make.exe -j 4
	goto END_PROG
	
:compile_SigningTool_64
	path
	Set PATH=%PATH%;%PATH_L_64%
	path
	cd  %ADR_SigningTool_64%
	git pull
	set OPENSSL_HOME=C:\Users\dhidahr\Desktop\sighning_tool\SigningTool\OpenSSL-Win32
	make clean
	del /s Makefile*
	qmake
	mingw32-make.exe -j 4
	goto END_PROG

:compile_SigningTool_32
	path
	Set PATH=%PATH%;%PATH_L_32%
	path
	cd  %ADR_SigningTool_32%
	git pull
	set OPENSSL_HOME=C:\Users\dhidahr\Desktop\sighning_tool\SigningTool\OpenSSL-Win32
	make clean
	del /s Makefile*
	qmake
	mingw32-make.exe -j 4
	goto END_PROG	

:END_PROG