@echo off
REM -----------------------------------------------------------------
REM  Script to stop catalog server on local host
REM -----------------------------------------------------------------
echo Stopping container server 1 on localhost...

stopOgServer.bat container1 -catalogServiceEndPoints anitha-pc:2810
