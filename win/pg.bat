@echo off

setlocal

set cmd=%1

if "%cmd%"=="help" (
  echo.
  echo Example usage:
  echo   %0 create postgresql
  echo.
  echo First argument is command
  echo   Available values: create/start/stop/delete
  echo.
  echo Second argument is service name. Specify what you want.
  
  exit /B
)


if "%cmd%"=="" set /p cmd="Enter command (create/start/stop/delete): "
if not "%cmd%"=="create" if not "%cmd%"=="start" if not "%cmd%"=="stop" if not "%cmd%"=="delete" (
    echo.
    echo Invalid command
    exit /B
)

set defaultServiceName=postgres
set serviceName=%2
if "%serviceName%"=="" set /p serviceName="Enter PostgreSQL service name (default %defaultServiceName%): "
if "%serviceName%"=="" set serviceName=%defaultServiceName%

echo.

call :%cmd%

endlocal

pause

exit /B


::------------------------------
:: Create service
::------------------------------
:create
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

exit /B 0


::------------------------------
:: Start service
::------------------------------
:start
echo Starting service %serviceName%...
sc start %serviceName%

exit /B 0


::------------------------------
:: Stop service
::------------------------------
:stop
echo Stopping service %serviceName%...
sc stop %serviceName%

exit /B 0


::------------------------------
:: Delete service
::------------------------------
:delete
::call :stop %serviceName%
call :stop
echo.
echo Deleting service %serviceName%...
sc delete %serviceName%

exit /B 0

::------------------------------
