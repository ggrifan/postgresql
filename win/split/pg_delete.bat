@echo off

setlocal

set defaultServiceName=postgresql

set serviceName=%1

if "%serviceName%"=="" set /p serviceName="Enter PostgreSQL service name to delete: "
if "%serviceName%"=="" set serviceName=%defaultServiceName%

call pg_stop.bat %serviceName%

echo.
echo Deleting service %serviceName%...

sc delete %serviceName%

endlocal

pause
