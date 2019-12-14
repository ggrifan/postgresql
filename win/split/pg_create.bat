@echo off

setlocal

set defaultServiceName=postgresql

set serviceName=%1

if "%serviceName%"=="" set /p serviceName="Enter PostgreSQL service name: "
if "%serviceName%"=="" set serviceName=%defaultServiceName%

echo.

if "%POSTGRESQL_HOME%"=="" (
    echo Environment variable POSTGRESQL_HOME doesn't defined
    exit /B
)
if "%POSTGRESQL_DATA%"=="" (
    echo Environment variable POSTGRESQL_DATA doesn't defined
    exit /B
)

echo Creating service %serviceName%...

sc create %serviceName% binPath= "\"%POSTGRESQL_HOME%\bin\pg_ctl.exe\" runservice -N \"%serviceName%\" -D \"%POSTGRESQL_DATA%\" -w" DisplayName= "%serviceName% server" obj= "NT AUTHORITY\NetworkService" start= "demand"

endlocal

pause
