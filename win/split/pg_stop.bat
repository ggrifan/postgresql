@echo off

setlocal

set defaultServiceName=postgresql-9.6

set serviceName=%1

if "%serviceName%"=="" set /p serviceName="Enter PostgreSQL service name to stop: "

if "%serviceName%"=="" set serviceName=%defaultServiceName%

echo.
echo Stopping service %serviceName%...

sc stop %serviceName%

endlocal

pause
