@echo off
setlocal ENABLEEXTENSIONS ENABLEDELAYEDEXPANSION

set "CMDARGS="
set i=2
:loop
call set "arg=%%%i%%"
if defined arg (
    set "CMDARGS=!CMDARGS! !arg!"
    set /a i+=1
    goto :loop
)

for /f "tokens=1*" %%a in ("!CMDARGS!") do (
    set "COMMAND=%%a"
    set "COMMAND_ARGS=%%b"
)

if "%1"=="" (
    goto :default
)

if "%1"=="-c" (
    goto :command
)
if "%1"=="--command" (
    goto :command
)

if "%1"=="-cr" (
    goto :command_run
)
if "%1"=="--command-run" (
    goto :command_run
)

goto :eof

:default
echo Default: Running MSYS2 / UCRT64
C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64
goto :eof

:command
echo Executing !CMDARGS!
C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64 -c "!CMDARGS!"
goto :eof

:command_run
echo Executing ./!COMMAND! !COMMAND_ARGS!
C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64 -c "./!COMMAND! !COMMAND_ARGS!"
goto :eof
