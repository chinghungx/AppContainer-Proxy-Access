::========== PLEASE RUN THIS SCRIPT WITH ADMINISTRATOR PRIVILEGE ==========

@ECHO OFF

SET admingroup=

FOR /F "tokens=*" %%a IN ('WHOAMI /GROUPS ^| FINDSTR /B "BUILTIN\Administrators" ^| FINDSTR /C:"Enabled group"') DO (
	SET admingroup=%%a
)

IF "%admingroup%" == "" (
	ECHO ERROR: Administrator privilege is required to run this script.
	PAUSE
) ELSE (
	:: Imports WinHTTP proxy settings
	netsh winhttp import proxy source=ie
)