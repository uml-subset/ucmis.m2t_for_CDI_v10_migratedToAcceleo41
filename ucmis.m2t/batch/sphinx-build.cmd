set startTime=%time%

rem Configuration start
rem *******************

set COPYRIGHT=2024, DDI Alliance
set LOGO=./_static/images/cdi.svg
set MODEL_NAME=DDI-CDI_1-0
set SPHINX_FILES=default
set TITLE=UML Model: DDI Cross Domain Integration (DDI-CDI 1.0)

rem *****************
rem Configuration end

set PROJECT_NAME=%1%
set PROJECT_LOC=%2%

xcopy %PROJECT_LOC%\about				^
  %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_rst\About /s /d /i /y
rem xcopy %PROJECT_LOC%\src					^
rem   %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_rst\About\%PROJECT_NAME%\src /s /d /i /y
xcopy %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_rst\definition.js	^
  %PROJECT_LOC%\sphinx\default\_static /d /y

sphinx-build.exe													^
  -b html															^
  -c %PROJECT_LOC%\sphinx\%SPHINX_FILES%							^
  -D copyright="%COPYRIGHT%"										^
  -D html_logo="%LOGO%"												^
  -D html_title="%TITLE%"											^
  %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_rst						^
  %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_build

@echo off  
echo Start Time: %startTime%
echo Finish Time: %time%