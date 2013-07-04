::echo       build-func %1

set function=%1
if "%function%" == "action" (
goto :action
) else (
call :%function% %2 %3 %4 %5 %6 %7 %8 %9
)
goto :eof

:action
call :prereport
if "%debug%" == "on" echo %actno% start- %action% 
if "%outfile%" == "" set outfile=null
if "%~1" == "" (
%action%
) else (
if "%~1" == "screen2file" %action% > %outfile%
if "%~1" == "append" %action% >> %outfile%
if "%~1" == "xml" (
echo ^<%~3/^> > %outfile%
)
)
call :postreport
goto :eof

:postreport
if  "%expectedreturn%" == "" set expectedreturn=0
IF %errorlevel% NEQ 0 (
   echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
   echo %errorlevel% %actno% FAIL - %action%
   echo -----------------------------------------------------------------
   echo XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX >>%logfile%
   echo %errorlevel%  %actno% XXXX  FAIL  XXXX - %report% >>%logfile%
   echo     %actno% failed command = %action% >>%logfile%    
   echo ----------------------------------------------------------------- >>%logfile%
   exit /b 0
   ) else (
   echo %errorlevel%  %actno% OK - %report% >>%logfile% 
   echo %errorlevel%  %actno% OK - %report% 
   )
set expectedreturn=
set /A actno=%actno%+1
goto :eof

:prereport
echo %actno% start - %action% >>%logfile%
goto :eof

:log
set record=%~1
echo    %actno% %record% >>%logfile%
echo    %actno% %record%
set /A actno=%actno%+1
goto :eof

:ccw
if "%~1" == "" (
set cctparam=-u -b -q -n
) else (
set cctparam=-b -q -n
)
cd %cctpath%
set action=%ccw32% %cctparam% -t "%script%" -o "%outfile%" "%infile%"
call:action
cd %basepath%
goto :eof

:setuplog
echo Setup log
set actno=1
set tenhour=%time:~0,1%
if "%tenhour%" == " " (
set myhour=0%time:~1,1%
) else (
set myhour=%time:~0,2%
)
if "%logtemp%" == "log" (
set logfile=%basepath%\%logtemp%\log-%date:~-4,4%-%date:~-7,2%-%date:~-10,2%T%myhour%%time:~3,2%%time:~6,2%.txt
) else (
set logfile=%basepath%\%projectpath%\log\log-%date:~-4,4%-%date:~-7,2%-%date:~-10,2%T%myhour%%time:~3,2%%time:~6,2%.txt
)
echo Starting %time% %date% ======================================>>%logfile%
goto :eof

:xslt
set action=%java%  -jar "%saxon9%"   -o "%outfile%" "%infile%" "%script%" %param%
call :before
%java%  -jar "%saxon9%"   -o "%outfile%" "%infile%" "%script%" %param%
call :after
goto :eof

:before
call :prereport
call :nameext "%outfile%"
if exist "%outfile%.pre.txt" (
del "%outfile%.pre.txt" 
echo deleted "%nameext%.pre.txt" >>%logfile%
)
if exist "%outfile%" (
ren "%outfile%" "%nameext%.pre.txt" 
echo renamed "%nameext%" to --} "%nameext%.pre.txt" >>%logfile%
)
goto :eof

:after
if not exist "%outfile%" (
set errorlevel=1
echo xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
echo XSLT transformation failed to create %nameext%.
echo XSLT transformation failed to create %nameext%. >>%logfile%
if exist "%outfile%.pre.txt" (
echo ren "%outfile%.pre.txt" "%nameext%"
ren "%outfile%.pre.txt" "%nameext%"
echo Previously existing %nameext% restored.
echo Previously existing %nameext% restored.>>%logfile%
echo The following processes will work on the previous version.
echo The following processes will work on the previous version.>>%logfile%
)
)
call :postreport
goto :eof

:nameext
set nameext=%~nx1
::echo %nameext%
goto :eof

:drivepath
set drivepath=%~dp1
echo %drivepath%
goto :eof

:binmay
set action="%binmay%" -s "%find%" -r "%replace%" -i "%infile%" -o "%outfile%"
call:action
goto :eof

:debug
:: Set debug to on or off. With "on" it will give more screen details
set debug=%~1
goto :eof

:serialtasks
call build-func log "Starting loop %~3"
set loopaction=%~1
set list=%~2
FOR /F %%s IN (%list%) DO call :%loopaction% %%s
goto :eof


:mixedtasks
call build-func log "===== Starting %~2 from %~nx1 "
set joinnodetest=off
set list=%~1
FOR /F "eol=# tokens=1,2,3,4,5,6,7,8,9,10 delims=_" %%i in (%list%) do call :%%i %%j %%k %%l %%m %%n %%o %%p %%q %%r 
set joinnodetest=
goto :eof


:build-string
:: Build a string of X separated variables
:: Parameters 
:: 1 variableName  required
:: 2 variable source required
:: 3 pre part of output element optional
:: 4 post part of output element optional
:: 5 separator if not comma optional

:: check and set variable
if "%~1" == "" goto:required
if "%~2" == "" goto:required

set varname=%~1
echo building var %~1  >>%logfile%
set varfile=%projectpath%\setup\%~2
if not exist "%varfile%" echo File %varfile% not found&pause &exit /b %errorlevel%
set tempname=
set prepart=%~3
set postpart=%~4
if "%~5" == "" (
  set sep=,
) else (
  set sep=%~5
)
set first=
set insertlinks=

FOR /F %%s IN ( %varfile% ) DO call:buildfield %%s
set %varname%=%tempname%
echo built %varname%=%tempname% >>%logfile%
echo built %varname%=%tempname%
goto :eof

:buildfield
set selfield=%~1
set field=%selfield:~1%
if "%selfield:~0,1%" == "_" (
if "%first%"=="1" (
set tempname=%tempname%%sep%%prepart%%field%%postpart%
) else (
set tempname=%prepart%%field%%postpart%
set first=1
echo %~1 included >>%logfile%
)
) else (
echo %~1 skipped >>%logfile%
)
goto :eof

:required
echo Required elements missing
echo variableName  variableSourceFile [prePart postPart separator]
goto :eof

:buildif
::set buildshell=%1
set buildlist=%~1
set relpath=%~2
set prepart=%~3
set postpart=%~4
FOR /F %%s IN (%buildlist%) DO call:buildfile %%s
goto :eof

:buildfile
set input=%~1
set field=%input:~1%
set report=Build string for %~1
set action=if not exist "%basepath%\%relpath%\%prepart%%field%%postpart%" call:doccw %field%
call build-func action
goto :eof

:buildlangjs
:: added missing goto :eof at end. causing doccw to run
echo // JavaScript Document>%outfile%
echo // Sets variables for use by Title page and Index selector.>>%outfile%
echo var ver_lang = "%langname%";>>%outfile%
echo var eng_lang = "English";>>%outfile%
echo var nat_lang = "%natlang%";>>%outfile%
echo var reg_lang = "%reglang%";>>%outfile%
echo var reg2_lang = "%reg2lang%";>>%outfile%
echo var reg3_lang = "%reg3lang%";>>%outfile%
echo var title = "%title%"; >>%outfile%
echo var intropage = "../../../works-%iso%.html";>>%outfile%
goto :eof

:numberedparams
:: Build a string of X separated variables
:: Parameters 
:: 1 variableName  required
:: 2 variable source required
:: 3 pre part of output element 

:: check and set variable
%lev3%echo Start numbered params string
if "%~1" == "" goto:required
if "%~2" == "" goto:required
set varname=%~1
set varfile=%projectpath%\setup\%~2
if not exist "%varfile%" pause
set tempname=
set prepart=%~3
set first=
set insertlinks=
set N=0
FOR /F %%s IN ( %varfile% ) DO call:buildparams %%s
goto :eof

:renamelast
set report=Named last file to %~1
set infile=%outfile%
set filename=%~1
call :drivepath "%infile%"
set action=copy /Y "%infile%" "%drivepath%%filename%" 
echo %action%
call :action
goto :eof

 :insertlinks
:: Insert hyperlinks
set report=Inserted links into %iso%-b.xml ready for final transform to html
set infile=%basepath%\%projectpath%\xml\%iso%-a.xml
set outfile=%basepath%\%projectpath%\xml\%iso%-b.xml
set script=%insertlinks%
call build-func ccw
goto :eof

:genericsort
set report=Sorted output on %~1 and %~2 
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-sorted.xml
set script=%basepath%\%xsltpath%\dict-sort-with-custom-collation-option.xslt
set param=translateaccents=%translateaccents% customfind=%customfind% customreplace=%customreplace% collationname="%collationname%" decchar2remove="%decchar2remove%" secondarysort=%secondarysort%
call :xslt
goto :eof

:normalizeallspace
set report=Normalized space in all elements
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-normalizedallspace.xml
set script=%basepath%\%xsltpath%\normalizeallspace.xslt
set param=node=%~1
call :xslt
goto :eof

:normalizespace
set report=Normalized space in %~1 node
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-normalizedspace.xml
set script=%basepath%\%xsltpath%\normalizespace.xslt
set param=node=%~1
call :xslt
goto :eof

:buildparams
set selfield=%~1
if "%selfield:~0,1%" neq "_" goto :eof
set /a N+=1
set field=%selfield:~1%
if "%first%"=="1" set tempname=%tempname% %prepart%%N%=%field%
if "%first%"=="" set tempname=%prepart%%N%=%field%&set first=1
goto :eof

:GenericGrouping
:: run changes to generate the structured xml %~1Group
set report=Made %~2Group within %~1 but excluding these fields:%~3
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-%~2Group.xml
set script=%basepath%\%xsltpath%\generic-grouping-with-exclude.xslt
set param=parentnode=%~1 groupnode=%~2 spacedlist="%~3"
call :xslt
goto :eof

:list2string
if "%~1" == "" goto:required
if "%~2" == "" goto:required
set varname=%~1
set templist=
set varfile=%projectpath%\setup\%~2
FOR /F %%s IN ( %varfile% ) DO call :addparam %%s
set %varname%=%templist%
call build-func log "Made param string from %~2: %templist%"
goto :eof

:addparam
set templist=%templist% %~1
goto :eof

:genericgroupserialnodes
set report=Grouped serial nodes together for: %~1
:: only groups immediately adjacent siblings
::call file2uri  %basepath%\%projectpath%\setup\serial-nodes-to-group.txt
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-serialGroup.xml
set script=%basepath%\%xsltpath%\generic-group-serial-nodes.xslt
set param=spacedlist="%~1"
call :xslt
goto :eof

:genericgroupreorder
:: created 2012-08-30T22:13:54 IKM
set report=Within %~1 reordered fields: %~2 %~3 %~4 %~5 %~6 %~7
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-reordered.xml
set script=%basepath%\%xsltpath%\generic-reorder-fields.xslt
set param=group=%~1 field1=%~2 field2=%~3 field3=%~4 field4=%~5 field5=%~6 field6=%~7
call :xslt
goto :eof


:genericgroupnodes
:: not working ian 2012-07-06
set report=Grouped %~2 within %~1 nodes
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-%~2Group.xml
set script=%basepath%\%xsltpath%\generic-group-nodes.xslt
set param=childnode=%~2 parentnode=%~1
call :xslt
goto :eof

:genericnewgroupselect
set report=Created new %~1Group contains %~1 %~2 %~3 %~4 %~5 %~6 %~7 %~8 %~9
:: this brings in all following siblings not just the first occurence
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1Group-%~2-%~3-%~4.xml
set script=%basepath%\%xsltpath%\generic-new-group-select.xslt
set param=node1=%~1 node2=%~2 node3=%~3 node4=%~4 node5=%~5 node6=%~6 node7=%~7 node8=%~8 node9=%~9
call :xslt
goto :eof

:genericaddprecedingtogroup
set report=Adds %~1 field to folowing %~2 
:: this brings in all following siblings not just the first occurence
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-addedto-%~2.xml
set script=%basepath%\%xsltpath%\generic-add-preceding-to-group.xslt
set param=includenode=%~1 groupnode=%~2 
call :xslt
goto :eof

:genericaddfollowingtogroup
set report=Adds %~1 field to preceding %~2 
:: this brings in all following siblings not just the first occurence
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-addedto-%~2.xml
set script=%basepath%\%xsltpath%\generic-add-following-to-group.xslt
set param=includenode=%~1 groupnode=%~2 
call :xslt
goto :eof

:genericGrouppair
set report=Made %~1Group containing %~1 and %~2
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1Group.xml
set script=%basepath%\%xsltpath%\generic-group-pair.xslt
set param=firstnode=%~1 secondnode=%~2 
call :xslt
goto :eof

:genericGrouptrio
set report=Made %~1Group containing %~1, %~2 and %~3
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1Group.xml
set script=%basepath%\%xsltpath%\generic-group-trio.xslt
set param=firstnode=%~1 secondnode=%~2 thirdnode=%~3
call :xslt
goto :eof

:genericGroupstartwithlist
set report=Made various peer Groupings starting with %~2
set list=%~2
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-Group-by-%~1-%list: =-%.xml
set script=%basepath%\%xsltpath%\generic-grouping-start-with-list.xslt
set param=spacedlist="%~2" parentnode="%~1"
call :xslt
goto :eof

:genericgroupinginsidelist
set report=Within %~1 grouped on %~2 but excluded list: %~3
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-Group-inside-%list: =-%.xml
set script=%basepath%\%xsltpath%\generic-grouping-inside-list.xslt
set param=parentnodes="%~1" groupnode="%~2"
call :xslt
goto :eof

:genericnodetexttranslate
set report=Replaced "%~2" with "%~3" in %~1 node text
set nodelist=%~1
set nodelist=%nodelist: =-%
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%nodelist%-modified.xml
set script=%basepath%\%xsltpath%\generic-nodetext-translate.xslt
set param=node="%~1" match="%~2" replace="%~3"
call :xslt
goto :eof

:genericbeforeafterreplace
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-modified.xml
set script=%basepath%\%xsltpath%\generic-before-after-replace.xslt
set report=Removed "%~2" from the beginning and "%~3" from the end of %~1 node text
set param=node="%~1" before="%~2" after="%~3"
call :xslt
goto :eof

:genericfinreplaceinnodes
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%~1-modified.xml
set script=%basepath%\%xsltpath%\generic-find-replace-in-nodes.xslt
set report=Replaced "%~2" with "%~3" within these nodes: %~1
set param=node="%~1" find="%~2" replace="%~3"
call :xslt
goto :eof

:joinnodes
set node=%~1
set separator=%~2
set infile=%outfile%
set script=%basepath%\scripts\xslt\generic-join-nodes.xslt
if "%joinnodetest%" == "off" (
set report=Join node %node% to immediate sibling and separate with %separator%
set outfile=%basepath%\%projectpath%\xml\%iso%-join-%node%.xml
set param=serialnode=%node% separator=%separator%
call :xslt
) else (
if "%node:~0,1%" == "_" (
set report=Join node %node:~1% to immediate sibling and separate with %~2
set outfile=%basepath%\%projectpath%\xml\%iso%-join-%node:~1%.xml
set param=serialnode=%node:~1% separator=%~2
call :xslt
) else (
call build-func log "Skipped %node:~1%"
)
)
goto :eof

:writechildnodetoxml
set curdata=%~2
set data=%curdata:~2%
if "%curdata:~0,2%" neq "_" goto :eof
set report=Added xml field {%childnode%}%data%{/%childnode%}
set action=xml ed -L -s /%parentnode% -t elem -n %childnode% -v %data% %outfile%
call build-func action
goto :eof

:validate
set report=Checked for well formed xml
set action=xml val -e "%outfile%"
call build-func action
goto :eof

:setdebug
echo %time%
set errorlevel=0
if "%debug%" == "on" (
echo on
) else (
echo off
)
goto :eof

:makelxJs
:: moved to build-func 20/08/2012 12:03:17 PM by IKM
set report=Made lx Java Script
call build-func build-string headwordfields indexver_source_fields.txt "" "" " "
set script=%basepath%\scripts\xslt\js-lx.xslt
set infile=%basepath%\%projectpath%\xml\%iso%-sorted.xml
set outfile=%localhostpath%\common\lx.js
set param=headwordfields="%headwordfields%"
call build-func xslt
goto :eof



:homonymnumberhandling
set outfilename=%~n3
set elementlist=%basepath%\%projectpath%\xml\%outfilename%.xml
set passedfrom=internal
call :text2xml fields element %3 %elementlist% internal
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-%outfilename%.xml
set script=%basepath%\scripts\xslt\homonymnumberhandling.xslt
call :file2uri %elementlist%
set param=elementlist=%uri% elementname=element
call :xslt
set passedfrom=
goto :eof

:text2xml
set infile=%outfile%
if "%~5" == "internal" (
set report=Made xml file from text list %~nx3
set root=%~1
set node=%~2
call :file2uri %~3

set outfile=%~4
) else (
set report=Made xml file from text list %~nx4
set root=%~1
set node=%~2
call :file2uri %~3
set outfile=%~4
)
set script=%basepath%\scripts\xslt\text2xml.xslt
set param=uri=%uri% root=%root% node=%node%
call :xslt  
goto :eof

:removenodes
if exist "%removelist%" (
call build-func build-string fields_to_remove fields_to_remove.txt "" "" " "
set report=Removed these elements: %fields_to_remove%
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-elements-removed.xml
set script=%basepath%\scripts\xslt\generic-remove-nodes.xslt
set param=removenodelist="%fields_to_remove%"
call build-func xslt  
) 
goto :eof

:linkmaker
:: Make Link ccts by xslt
set report=made cct for %field% linkmaker 
set infile=%projectpath%\xml\%iso%-sorted.xml
set outfile=%projectpath%\log\link-ccts-created.txt
set script=scripts\xslt\link-gen-cct.xslt
call :file2url %basepath%\%projectpath%\setup\link_target_fields.txt
set param=field=%field% elementlist=file:///%fsbasepath%/%fsprojectpath%/xml/link_target_fields.xml
call build-func xslt 
)
goto :eof

:file2uri
:: made redundant 20/07/2012 11:35:47 AM IKM
set file=%~1
set numb=$~2
set uri%numb%=file:///%file:\=/%
goto :eof

:makecctstring
:: made redundant 20/08/2012 11:35:47 AM IKM
:: Make cct file string
set report=Built cct serial string
::set action=call :build-string insertlinks link_source_fields.TXT link- .cct
call build-func build-string insertlinks link_source_fields.TXT link- .cct
goto :eof

:combinejs
:: created 15/08/2012 12:19:21 PM by IKM
:: problems with previous creation. Reasons of problem unknown. 
:: This is faster as only one write
:: Moved to Build-func 20/08/2012 12:21:01 PM
set buildindex=Indexs_to_build.txt
::if not exist %buildindex% set errorlevel=1
call build-func build-string joinbycopy %buildindex% %basepath%\%projectpath%\xml\alphalinks- .txt +
set report=Copied: %joinbycopy% to letters.js
set outfile=%basepath%\%projectpath%\xml\letters.txt
set expectedreturn=123
copy %basepath%\setup\letters.txt+%joinbycopy% "%outfile%"
echo copy shells\letters.txt+%joinbycopy% "%outfile%"
goto :eof

:fixinline
set report=Inline SFM tags converted to xml
set script=inline2xmlv2.cct
if exist %projectpath%\setup\post-xml-inline-ccts.txt (
call build-func build-string postxmlinlineccts post-xml-inline-ccts.txt "," "" ""
set script=%script%%postxmlinlineccts%
) 
set infile=%outfile%
set outfile=%xmlpath%\%iso%-inlinefixed.xml
call build-func ccw
set report=Check if well formed after cct has run
call build-func validate
goto :eof


:fixjs
:: fix js file with illegal character
:: moved to build-func 20/08/2012 12:23:10 PM by IKM
set report=letters.js stripped of d26 character
set infile=%outfile%
set outfile=%localhostpath%\common\letters.js
::set script=js-fix.cct
set find=1A
set replace=
::call build-func ccw
set expectedreturn=1
call build-func binmay
goto :eof

:preindex
copy "%outfile%" "%projectpath%\xml\%iso%-preindex.xml"
echo copy "%outfile%" "%projectpath%\xml\%iso%-preindex.xml">>%logfile%
echo copied last file to %iso%-preindex.xml
goto :eof

:splitnodes
set splitlist=%~1
:: moved from build-index to build-func 20/08/2012 12:36:49 PM by IKM

::call file2uri %~1
call build-func build-string build-string %splitlist% "" "" " "
set infile=%outfile%
set report=Split nodes: %spacedlist% on %separatorstring% 
set outfile=%basepath%\%projectpath%\xml\%iso%-index-split.xml
set script=%basepath%\scripts\xslt\generic-split-string-for-nodes.xslt
set param=elementstosplit="%spacedlist%" separatorstring="%separatorstring%"
if exist %basepath%\%projectpath%\setup\%splitlist% call build-func xslt

goto :eof

:unicodecount
call :prereport
if "%~1" neq "" set infile=%~1
if "%~2" neq "" set outfile=%~2
"%unicodeccount%" -o "%outfile%" "%infile%"
call :postreport %errorlevel%
goto :eof

:marksenseinfields
set report=Added sense element around sense numbers in fields: %~1
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\%iso%-sense-marked.xml
set script=%basepath%\scripts\xslt\mark-sense-in-fields.xslt
set param=findsenseinelementlist="%~1"
call build-func xslt
call :postreport %errorlevel%
goto :eof

:postxmlccts
set report=Post XML processing by cct
if exist %projectpath%\setup\post-xml-ccts.txt (
call build-func build-string postxmlccts post-xml-ccts.txt "" "" ","
) else (
set postxmlccts=
)
::if "%postxmlccts%" neq "" set sep=,
if "%postxmlccts%" neq ""  (
set infile=%outfile%
set outfile=%xmlpath%\%iso%-postxmlccts.xml
set script=%postxmlccts%
call build-func ccw
set report=Check if well formed after cct has run
call build-func validate 
)
goto :eof