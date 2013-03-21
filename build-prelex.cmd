call build-func setdebug
call build-func setuplog
echo =============================================
call build-func log "build-prelex"
if "%iso%" == "" call projects.cmd %1

call :splitstringfornodesbycomma 
call build-func log "Start making link ccts from link_source_fields.txt"
call :makealllinkccts
call build-func build-string insertlinks link_source_fields.TXT link- .cct
call build-func insertlinks
::FOR /F %%s IN (%varlist%) DO call:linkmaker  %%s

goto:eof

:splitstringfornodesbycomma
call build-func build-string elementstosplit link_source_fields.txt "" "" " "
set report=Split fields: %elementstosplit% - on comma
set infile=%projectpath%\xml\%iso%-sorted.xml
set outfile=%projectpath%\xml\%iso%-sorted-split4links.xml
set script=%basepath%\%xsltpath%\generic-split-string-for-nodes.xslt
::call file2uri %basepath%\%projectpath%\setup\link_source_fields.txt
set param=separatorstring=, elementstosplit="%elementstosplit%"
call build-func xslt
goto:eof

:makealllinkccts
::echo on
set infile=%outfile%
set outfile=%projectpath%\log\link-ccts-made.txt
call build-func build-string sourcelist link_source_fields.txt "" "" " "
call build-func build-string targetlist link_target_fields.txt "" "" " "
echo sourcelist=%sourcelist%
echo targetlist=%targetlist%
if "%sourcelist%" == "" set sourcelist= xxx
if "%targetlist%" == "" set targetlist= zzz
call file2uri %basepath%
set report=Made link ccts for each of: %sourcelist% inserted into: %targetlist%
::call file2uri %basepath%\%projectpath%\setup\link_source_fields.txt
::call file2uri %basepath%\%projectpath%\setup\link_target_fields.txt 2
set script=%xsltpath%\link-gen-cct.xslt
set param=sourcelist="%sourcelist%" targetlist="%targetlist%" basepath=%uri% namelink=on
call build-func xslt 
::echo off
goto:eof

