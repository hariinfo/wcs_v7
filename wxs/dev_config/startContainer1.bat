@echo off
REM -----------------------------------------------------------------
REM  Script to start ccontainer server on local host
REM -----------------------------------------------------------------
echo Starting container server on localhost...

startOgServer.bat container1 -objectGridFile C:\IBM\WebSphere\eXtremeScale\ObjectGrid\dynacache\etc\dynacache-remote-objectgrid.xml -deploymentPolicyFile C:\IBM\WebSphere\eXtremeScale\ObjectGrid\dynacache\etc\dynacache-remote-deployment.xml -catalogServiceEndPoints anitha-pc:2810
