@ECHO OFF
SETLOCAL EnableExtensions

REM Get the directory location of this script, assume it contains the OpenViBE dist tree. These variables will be used by OpenViBE executables.
SET "OV_PATH_ROOT=%~dp0"
SET "OV_PATH_BIN=%OV_PATH_ROOT%\bin"
SET "OV_PATH_LIB=%OV_PATH_ROOT%\bin"
SET "OV_PATH_DATA=%OV_PATH_ROOT%\share\openvibe"

SET OV_PAUSE=PAUSE
SET OV_RUN_IN_BG=

IF /i "%1"=="--no-pause" (
	SET OV_PAUSE=
	SHIFT
)
IF /i "%1"=="--run-bg" (
	REM Run in background, disable pause. The first start arg is the app title.
	SET OV_RUN_IN_BG=START "openvibe-ssvep-demo.exe"
	SET OV_PAUSE=
	SHIFT
)

SET "OV_ENVIRONMENT_FILE=%OV_PATH_ROOT%\bin\OpenViBE-set-env.cmd"
IF NOT EXIST "%OV_ENVIRONMENT_FILE%" (
	ECHO Error: "%OV_ENVIRONMENT_FILE%" was not found
	GOTO EndOfScript
)
CALL "%OV_ENVIRONMENT_FILE%"

%OV_RUN_IN_BG% "%OV_PATH_ROOT%\bin\openvibe-ssvep-demo.exe" shooter %1 %2 %3 %4 %5 %6
	
:EndOfScript

%OV_PAUSE%

