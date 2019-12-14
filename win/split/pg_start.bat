@echo off

setlocal

set defaultServiceName=postgresql

set /p serviceName="Enter PostgreSQL service name to start: "

if "%serviceName%"=="" set serviceName=%defaultServiceName%

echo.
echo Starting service %serviceName%...

net start %serviceName%

endlocal

pause
