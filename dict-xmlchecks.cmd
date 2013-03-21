:: dict-xmlchecks
:: Created 27/08/2012 4:23:48 PM IKM
:main
echo off
set report=
call build-func setdebug
call build-func setuplog
echo =============================================

call build-func log "dict-xmlchecks"
call :countfields
call :countfieldsprehtml
call :reportxml2text fields fieldlist fieldlist
call :reportxml2text fields field-count fieldcount
::call :fieldlist
copy "%projectpath%\checks\fieldlist.txt" "%projectpath%\setup\fieldlist.txt"
call build-func list2string fieldlist fieldlist.txt
call :fieldsummary "%fieldlist%"

goto :eof

:countfields
:: run fields check Transform
set report=Field counts made of flat file
set infile=%basepath%\%projectpath%\xml\%iso%-flat.xml
set outfile=%basepath%\%projectpath%\checks\fields.xml
set script=%basepath%\%xsltpath%\%countfields%
set param=par=none
call build-func xslt
goto:eof

:reportxml2text
:: run fields check Transform
set inname=%~1
set outname=%~2
set reporttype=%~3
set report=%reporttype% text file made from %inname%.xml output to %outname%.txt
set infile=%basepath%\%projectpath%\checks\%inname%.xml
set outfile=%basepath%\%projectpath%\checks\%outname%.txt
set script=%basepath%\%xsltpath%\check-make-tab-file.xslt
set param=reporttype=%reporttype%
call build-func xslt
goto:eof


:countfieldsprehtml
:: count fields actually occuring pre HTML
set report=Field counts made of structured xml file
set infile=%basepath%\%projectpath%\xml\%iso%-a.xml
set outfile=%basepath%\%projectpath%\checks\fields-prehtml.xml
set script=%basepath%\%xsltpath%\check-count-fields-prehtml.xslt
set param=par=none
call build-func xslt
goto:eof

:fieldsummary
:: to create many reports from one pass.
:: 
set report=%~1 field varieties counted
call file2uri %basepath%\%projectpath%\checks\fields\
set infile=%basepath%\%projectpath%\xml\%iso%-flat.xml
set outfile=%basepath%\%projectpath%\log\fieldchecksmade.txt
set script=%basepath%\%xsltpath%\check-field-values-summary.xslt
set param=fieldlist="%~1" uripath="%uri%"
call build-func xslt
::if not exist "%outfile%" call build-func xslt
goto:eof



