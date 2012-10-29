@echo off
REM -----------------------------------------------------------------
REM  Script to stop catalog server on local host
REM -----------------------------------------------------------------
echo Stopping container server 2 on localhost...

stopOgServer.bat container2 -catalogServiceEndPoints anitha-pc:2810
