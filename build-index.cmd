call build-func setdebug
call build-func setuplog
echo ==================================================
call build-func log "Build Indexes and lx.js"
if "%iso%" == "" call projects.cmd %1
if exist %basepath%\%projectpath%\xml\letters.temp del %basepath%\%projectpath%\xml\letters.temp
call :makeindexsourcexslt
call :langloop
call build-func combinejs
call build-func fixjs

call build-func makelxJs
goto:eof

:makeindexsourcexslt
call build-func log "Starting to split index fields supplied in: fields_to_split.txt"
rem The following line added incase the sorted file is not processed enough. Used in ssb first.
if exist %basepath%\%projectpath%\xml\%iso%-preindex.xml (
set outfile=%basepath%\%projectpath%\xml\%iso%-preindex.xml 
) else (
set outfile=%basepath%\%projectpath%\xml\%iso%-sorted.xml
)
if "%splitseparator%" == "" (
rem this will use xslt default value
set separatorstring=
) else (
set separatorstring=%splitseparator%
)
::call removenodes %basepath%\%projectpath%\setup\index-fields_to_remove.txt
call build-func splitnodes fields_to_split.txt
call build-func renamelast %iso%-index.xml
set indexsource=%projectpath%\xml\%iso%-index.xml
goto:eof

:langloop
call build-func log "Start Lang loop"
set langlist=%projectpath%\setup\Indexs_to_build.txt
echo // JavaScript Document > "%localhostpath%\common\letters.txt"
FOR /F %%s IN (%langlist%) DO call :langindextasks  %%s
goto:eof

:langindextasks
set longvar=%~1
set index=%longvar:~1%
if "%longvar:~0,1%" == "_" (
call build-func log "Start Lang index tasks ========================: %index%"
call :indexgenerate
call :indexsortngroup
call :htmlize
::call:split
call :alphalinks
) else (
call build-func log "Skipping: %longvar%"
)
::echo    Done index tasks
goto :eof

:indexgenerate
::set report=Built parameters
call build-func build-string params index%index%_source_fields.txt "" "" " "
set report=Generated index raw file
set infile=%basepath%\%projectpath%\xml\%iso%-index.xml
set outfile=%basepath%\%projectpath%\xml\index-%index%-joined.xml
set script=%basepath%\%xsltpath%\index-get-fields.xslt
set param=sourcetextstring="%params%"
call build-func xslt
goto:eof

:indexsortngroup
set report=Index Sort and group
set script=%basepath%\%xsltpath%\Index-group-n-sort.xslt
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\index-%index%-grouped.xml
set param=translateaccents=%translateaccents% customfind="%customfind%"" customreplace="%customreplace%"" collationname=%collationname%  decchar2remove="%decchar2remove%" secondarysort=%secondarysort% digraphlist="%digraphlist%"
call build-func xslt
goto:eof

:htmlize
set report=Transformed to split %index% index html
set script=%basepath%\%xsltpath%\index2split-html.xslt
set infile=%outfile%
set outfile=%basepath%\%projectpath%\log\%iso%-%index%-index.log
call file2uri=%htmlpath%\index
set param=path=%uri% splitelement=alpha index=%index%  spacebeforehom=%spacebeforehom%
call build-func xslt
goto:eof

:alphalinks
set report=Run Alpha links transformation
set script=%basepath%\%xsltpath%\index_letters_head.xslt
set infile=%basepath%\%projectpath%\xml\index-%index%-grouped.xml
set outfile=%basepath%\%projectpath%\xml\alphalinks-%index%.txt
set param=curlang=%index% 
call build-func xslt
goto:eof

:done
echo Index Build complete ------------------------------
cd %basepath%