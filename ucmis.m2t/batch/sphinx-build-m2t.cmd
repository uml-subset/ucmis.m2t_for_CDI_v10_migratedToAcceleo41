rem Configuration start
rem *******************

set MODEL_NAME=ucmis.m2t
set SPHINX_FILES=ucmis.m2t
set TITLE=M2T Documentation

rem *****************
rem Configuration end

set PROJECT_NAME=%1%
set PROJECT_LOC=%2%

sphinx-build.exe													^
  -b html															^
  -c %PROJECT_LOC%\sphinx\%SPHINX_FILES%							^
  -D html_title="%TITLE%"											^
  %PROJECT_LOC%\generated\%MODEL_NAME%\_rst							^
  %PROJECT_LOC%\generated\%MODEL_NAME%\_build
