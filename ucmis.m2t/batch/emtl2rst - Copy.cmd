rem D:\Eclipse\eclipse-workspace_2020-11\ucmis.m2t\bin\ucmis\m2t\target\doc
set ECLIPSE_WORKSPACE=D:\Eclipse\eclipse-workspace_2020-11\ucmis.m2t
rem set ECLIPSE_WORKSPACE=%1%

cd %ECLIPSE_WORKSPACE%\bin\ucmis\m2t

:treeProcess
cd
for %%f in (*.emtl) do echo %%f
for /D %%d in (*) do (
    cd %%d
    call :treeProcess
    cd ..
)
rem cd ..
rem exit /b