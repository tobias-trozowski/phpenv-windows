@ECHO OFF
setlocal DISABLEDELAYEDEXPANSION
#..\versions\7.0.0\php.exe %*
Powershell -NoProfile  -ExecutionPolicy Bypass -Command "Invoke-PhpEnv %*"