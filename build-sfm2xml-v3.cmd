:main
:: updated 2012-08-14 IKM
echo off
set report=
call build-func setdebug
call build-func setuplog
call localvar
echo =============================================
call build-func log "build-sfm2xml"
if "%2" == "%iso%" (
goto :%1
goto :eof
)
call :checkiso
:: choose depending if pre-xml-ccts.txt exists. if it does use xslt to convert sfm instead of ccts
if exist "%setuppath%\pre-xml-ccts.txt" (
call build-func build-string prexmlcct pre-xml-ccts.txt
call :prexmlccts
call :sfm2xml %xmlpath%\%iso%-prexml.txt tb
) else (
call build-func build-string prexmlcct sfm2xml_ccts.txt
call :flatxml
call build-func validate

)
call build-func removenodes %removelist%
call build-func postxmlccts
::call build-func normalizeallspace
:: The inline markup needs to be made into xslt at some time.
call build-func genericgrouping database lx
call build-func genericsort lx %secondarysort%
::call build-func log "===== Main %type% groupings and sorting ====="
::call :%type%_grouping
call build-func mixedtasks %setuppath%\extra-tasks.txt "Project specific tasks"
call :fixinline
call build-func renamelast %iso%-a.xml 
:: removed checks to separate cmd file dict-xmlchecks.cmd
:: 27/08/2012 4:23:26 PM IKM
echo %time%
goto :eof


:checkiso
set report=Checked if iso code set, if not ran projects.cmd
set action=if "%iso%" == "" call projects.cmd %1
call build-func action
goto :eof

:prexmlccts
:: updated 2012-08-14 IKM
set report=sfm modified by ccts: %prexmlcct%
set outfile=%xmlpath%\%iso%-prexml.txt
goto :prexcommon
:flatxml
set report=sfm converted to xml by: %prexmlcct%
set outfile=%xmlpath%\%iso%-flat.xml
:prexcommon
set infile=%basepath%\%projectpath%\%source%
set script=%prexmlcct%
call build-func ccw

goto:eof

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



:sfm2xml
:: created 2012-08-14 by Ian McQuay
set report=SFM file converted to XML
call file2uri %~1

set infile=%basepath%\%xsltpath%\blank.xml
set outfile=%xmlpath%\%iso%-flat.xml
set script=%basepath%\%xsltpath%\sfm2xml-dict2.xslt
set param=sourcetexturi=%uri% tablemarker=%~2
call build-func xslt
goto:eof


:plb_grouping
call build-func genericGroupPair ex tr
goto:eof

:ssb_grouping
call build-func genericgrouptrio ex tr fr
goto :eof

:localvar

goto :eof

echo --------------------------------------------
:done