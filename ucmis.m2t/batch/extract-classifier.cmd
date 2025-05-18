rem Issues with direct transform with saxon in Eclipse.
rem Message: The system identifier of the principal output file is unknown.
rem Therefore this solution with a command file.
rem FIX: click on project before running launch file

rem %1 is ${project_loc}
set TARGET_FOLDER=%1\generated\DDI-CDI_1-0\doc\_rst\xmi\
rem set TARGET_FOLDER=E:\Git\ucmis.m2t\generated\DDI-CDI_1-0\doc\_rst\xmi\
if not exist "%TARGET_FOLDER%" mkdir %TARGET_FOLDER%
call saxon -s:"%1\model\DDI-CDI_2022-07-20-unique-names.xmi" -xsl:"%1\xslt\ExtractClassifier.xslt" -o:"%TARGET_FOLDER%dummy"