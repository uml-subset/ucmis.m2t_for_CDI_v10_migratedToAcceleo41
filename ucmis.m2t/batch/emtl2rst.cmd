@echo off
set ECLIPSE_WORKSPACE=D:\Eclipse\eclipse-workspace_2020-11\ucmis.m2t
rem set ECLIPSE_WORKSPACE=%1%

cd %ECLIPSE_WORKSPACE%\bin\ucmis\m2t

:treeProcess
echo %1
for %%f in (*.emtl) do echo %%f
for /D %%d in (*) do (
    cd %%d
	set pp=%1%\%%d
    call :treeProcess %pp%
    cd ..
)
exit /b
rem D:\Eclipse\eclipse-workspace_2020-11\ucmis.m2t\batch