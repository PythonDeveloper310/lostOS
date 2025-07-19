@echo off

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
C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64
goto :eof

:command
C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64 -c "%2"
goto :eof

:command_run
C:\msys64\msys2_shell.cmd -defterm -here -no-start -ucrt64 -c "./%2 %3"
goto :eof