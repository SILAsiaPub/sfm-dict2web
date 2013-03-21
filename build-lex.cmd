call build-func setdebug
call build-func setuplog
echo ==================================================
call build-func log "Build-lex"
if "%iso%" == "" call projects.cmd %1

call :transformtosplithtml
goto :eof



:transformtosplithtml
:: Main transformation from xml to multi html
call build-func log ". . . Transforming xml into many html"
set report=Done transfromation to html
set infile=%basepath%\%projectpath%\xml\%iso%-b.xml
set outfile=%basepath%\%projectpath%\log\%iso%-output-files.txt
:: tests if an xslt template is defined in the %iso%.cmd file. Used the defined file if it is there.
if exist "%basepath%\%projectpath%\%xslttemplate%"  (
set script=%basepath%\%projectpath%\%xslttemplate%
) else (
set script=%basepath%\%projectpath%\%iso%.xslt
)
if not exist %htmlpath%\lexicon md %htmlpath%\lexicon
call file2uri %htmlpath%\lexicon
set param=path=%uri% labelname="%langname%" foreachelement=lxGroup removechar="%removechar%" spacebeforehom=%spacebeforehom%
call build-func xslt
goto:eof



:: delete existing localhost html files
:: set report=Deleted existing html files  if found
:: set action=if exist "%localhostpath%\prog\%iso%\lexicon\lx*.html" del /Q "%localhostpath%\prog\%iso%\lexicon\lx*.html"
:: call build-func action

:: split mega html file
:: %csplit% -f "%localhostpath%\prog\%iso%\lexicon\lx" -n 5 "%basepath%\%projectpath%\xml\%iso%.xml" /encoding=/ {*} 

:: Check if split file lx00002 made
:: set report=Multi-html file split into individual files
:: set action=if not exist "%localhostpath%\prog\%iso%\lexicon\lx00002" set errorlevel=2
:: call build-func action

:: rename files
:: set report=Renamed lex files in localhost
:: set action=ren "%localhostpath%\prog\%iso%\lexicon\lx*" "lx*.html"
:: call build-func action


:prereq
:: redundant. not used 20/05/2012 11:36:34 AM
set report=Run prerequisites
set action=if not exist "%projectpath%\%iso%-a.xml" echo Requires build-sfm2xml &call build-sfm2xml.cmd %iso%
call build-func action
set report=Run prerequisites
set action=if not exist "%projectpath%\%iso%-a.xml" echo Requires build-xslt &call build-xslt.cmd %iso%
call build-func action
set report=Run prerequisites
set action=if not exist "%projectpath%\%iso%-a.xml" echo Requires build-prelex &call build-prelex.cmd
call build-func action
goto:eof

