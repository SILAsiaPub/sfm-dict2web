:: collection of unused code

:renamelast
:: redundant now in build-func 20/08/2012 12:14:45 PM by IKM
:: removed from build-index 
set infile=%outfile%
set outfilenameext=%~1
call :filenameext %infile%
set report=Renamed: %filenameext% to ==} %outfilenameext%
if exist "%drivepath%\%outfilenameext%" del "%drivepath%\%outfilenameext%"
set action=ren "%infile%" "%outfilenameext%"
call build-func action
goto:eof

:file2uri
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: In a separate file
set file=%~1
set uri=file:///%file:\=/%
goto:eof

:filenameext
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant
set drivepath=%~dp1
set filenameext=%~nx1
goto:eof

:loop
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant
call build-func log "Starting loop %~1"
set loopaction=%~1
set list=%~2
FOR /F %%s IN (%list%) DO call :processloopdata %%s
goto:eof

:: split elements for Index if needed
:makeindexsource
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant
set report=Built splitfields string
set action=call build-func build-string splitfields fields_to_split.TXT split- .cct
call build-func action

set report=Made %iso%-index.xml source file
set infile=%basepath%\%projectpath%\xml\%iso%-lxGroup.xml
set outfile=%basepath%\%projectpath%\xml\%iso%-index.xml
set script=remove-char-xml.cct,%splitfields%
call build-func ccw
goto:eof

:processloopdata
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant
set data=%~1
::set task=%~1
if "%data:~0,1%" == "_" (
echo     Start %loopaction% for %data:~1%
call :%loopaction% %data:~1%

) else (
echo Skipped %data%>>%logfile%
)
goto:eof

:removenode
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant
set node=%~1
set infile=%outfile%
set report=Removed %node% node
set outfile=%basepath%\%projectpath%\xml\%iso%-removed-%node%.xml
set script=%basepath%\scripts\xslt\generic-remove-node.xslt
set param=removenode=%node%
call build-func xslt  
goto:eof

:splitnode
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant
set node=%~1
set infile=%outfile%
set report=Split %node% node on %separatorstring%
set outfile=%basepath%\%projectpath%\xml\%iso%-split-%node%.xml
set script=%basepath%\scripts\xslt\generic-split-string.xslt
set param=splitnode=%node% separatorstring=%separatorstring%
call build-func xslt
goto:eof

:split
:: removed from build-index  20/08/2012 12:24:34 PM  by IKM
:: redundant

set report=Deleted existing index html files in localhost if present
set action=if exist "%localhostpath%\index\%index%*.html" del "%localhostpath%\index\%index%*.html*"
call build-func action

call build-func log "Starting to split multi-html file"
%csplit% -f "%localhostpath%\prog\%iso%\index\%index%" "%basepath%\%projectpath%\xml\%index%.xml" /^<html/ {*}

set report=Completed split of multi-html file
set action=if not exist ..\index\%index%02 set errorlevel=1
call build-func action

set report=Renamed split files in localhost path
set action=ren "%localhostpath%\index\%index%*" *.html
call build-func action
goto:eof

:doccw
:: redundant 
:: removed to build-unused 23/08/2012 8:39:26 AM IKM
set field=%~1
::del %basepath%\%relpath%\temp.cct
echo '%%xx%%'           ^>          '%field%'>%basepath%\%relpath%\temp.cct
set infile=%basepath%\shells\%prepart%xx%postpart%.shell
set outfile=%basepath%\%relpath%\%prepart%%field%%postpart%
set script=%basepath%\%relpath%\temp.cct
call build-func ccw 
goto:eof

:buildcctlist
::redundant
:: removed from sfm2xml 27/08/2012 4:28:40 PM by IKM
:: run changes to generate flat xml file to count fields and barcode fixes
set report=sfm2xml cct string made
::set action=call :
call build-func build-string sfm2xmlccts sfm2xml_ccts.txt

goto:eof

:loop
:: depreciated
::redundant
:: removed from sfm2xml 27/08/2012 4:28:40 PM by IKM
call build-func log "Starting loop %~1"
set loopaction=%~1
set list=%~2
FOR /F %%s IN (%list%) DO call :processloopdata %%s
goto:eof



:processloopdata
:: depreciated
::redundant
:: removed from sfm2xml 27/08/2012 4:28:40 PM by IKM
set data=%~1
::set task=%~1
if "%data:~0,1%" == "_" (
echo     Start %loopaction% for %data:~1%
call :%loopaction% %data:~1%

) else (
echo Skipped %data%>>%logfile%
)
goto:eof

::redundant
:: removed from sfm2xml 27/08/2012 4:28:40 PM by IKM
:: make a character count by cct
set report=Counted characters
set infile=%basepath%\%projectpath%\%source%
set outfile=%basepath%\%projectpath%\checks\char-count.txt
set script=%charcountcct%
::call build-func ccw
goto:eof

:renamelast
:: depreciated
:: removed from sfm2xml 27/08/2012 4:28:40 PM by IKM
set infile=%outfile%
set outfilename=%iso%-a.xml
set outfile=%basepath%\%xsltpath%\%outfilename%
set report=Renamed last grouping to %outfilename%
if exist "%outfile%" del "%outfile%"
set action=ren "%infile%" "%outfilename%"
call build-func action
goto:eof

:nodetranslate
:: depreciated
set report=Translate "%~2" in node %~1 into "%~3"
set infile=%outfile%
set outfile=%basepath%\%projectpath%\%iso%-%~1-trans%actno%.xml
set script=%basepath%\%xsltpath%\node-translate.xslt
set param=node=%~1 trans=%~2 replace=%~3
call build-func xslt
goto:eof

:fieldlist
set report=%~1 field varieties counted
set infile=%basepath%\%projectpath%\checks\fields.xml
set outfile=%basepath%\%projectpath%\setup\fieldlist.txt
set script=%basepath%\%xsltpath%\check-field-values-summary.xslt
set param=fieldlist="%~1"
goto:eof