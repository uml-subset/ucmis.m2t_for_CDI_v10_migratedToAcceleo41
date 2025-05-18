rem Configuration start
rem *******************

set MODEL_NAME=UCMISExample
set SPHINX_FILES=ucmis
set TITLE=UCMIS Representation Mapping

rem *****************
rem Configuration end

set PROJECT_NAME=%1%
set PROJECT_LOC=%2%

sphinx-build.exe													^
  -b html															^
  -c %PROJECT_LOC%\sphinx\%SPHINX_FILES%							^
  -D html_title="%TITLE%"											^
  %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_rst						^
  %PROJECT_LOC%\generated\%MODEL_NAME%\doc\_build
