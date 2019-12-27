@echo off

set file_to_read=..\..\config.cfg
set /a adr_file_manag_32=10
set /a adr_file_manag_64=12
set /a adr_path_gui=8
set /a adr_path_prog_32=18
set /a adr_path_prog_64=20
set /a adr_pack_creator_32=14
set /a adr_pack_creator_64=16
set /a adr_KeyGen_64=22
set /a adr_KeyGen_32=24
set /a adr_SigningTool_64=26
set /a adr_SigningTool_32=28

set /A counter=1
setlocal ENABLEDELAYEDEXPANSION


for /f "delims=*" %%A  in (%file_to_read%) do (
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
IF [%1]==[64] GOTO check_64
IF [%1]==[32] GOTO check_32
IF [%1]==[FileManager_32] GOTO check_FileManager_32
IF [%1]==[FileManager_64] GOTO check_FileManager_64
IF [%1]==[STM32TrustedPackageCreator_32] GOTO check_STM32TrustedPackageCreator_32
IF [%1]==[STM32TrustedPackageCreator_64] GOTO check_STM32TrustedPackageCreator_64
IF [%1]==[KeyGen_64] GOTO check_KeyGen_64
IF [%1]==[KeyGen_32] GOTO check_KeyGen_32
IF [%1]==[SigningTool_64] GOTO check_SigningTool_64
IF [%1]==[SigningTool_32] GOTO check_SigningTool_32

IF [%1]==[gui] GOTO check_gui


IF [%1]==[""] (
	ECHO set parameter :  64 or 32 bit or FileManager_32 or FileManager_64 or STM32TrustedPackageCreator_64 or STM32TrustedPackageCreator_32
	goto END_PROG
)	ELSE (
	ECHO set parameter :  64 or 32 bit or FileManager_32 or FileManager_64 or STM32TrustedPackageCreator_64 or STM32TrustedPackageCreator_32
	goto END_PROG
)


:check_64
	cd %ADR_prog_64%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

	goto END_PROG

:check_32
	cd %ADR_prog_32%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

	goto END_PROG
:check_FileManager_32
	cd %ADR_FILEMANGER_32%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

	goto END_PROG
:check_FileManager_64
	cd %ADR_FILEMANGER_64%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

	goto END_PROG
:check_STM32TrustedPackageCreator_32
	cd %ADR_packcreator_32%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

	goto END_PROG
:check_STM32TrustedPackageCreator_64
	cd %ADR_packcreator_64%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

:check_gui
	cd %ADR_GUI%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )

	goto END_PROG

:check_KeyGen_64
	cd %ADR_KeyGen_64%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )
	goto END_PROG

:check_KeyGen_32
	cd %ADR_KeyGen_32%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )
	goto END_PROG

:check_SigningTool_64
	cd %ADR_KeyGen_64%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )
	goto END_PROG

:check_SigningTool_32
	cd %ADR_KeyGen_32%
	git branch | find "* develop" > NUL & IF ERRORLEVEL 1 (
	ECHO I am not on develop
	git checkout develop
	git pull origin develop
	)ELSE (
	ECHO I am on develop
	git pull origin develop )
	goto END_PROG
	
	
:End_prog