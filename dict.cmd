echo off
::call:debugsettings
call :setup %1
::set return=dict
:menu1
echo off
echo %time%
::set menuname=menu1
::cls
echo[
echo        Choose starting task if needed for  = %iso% - %langname%
echo        0. Checks on sfm file          &set option0=dict-sfmchecks
echo[ 
echo        Select task to perform:
echo        A. Make xml from sfm and structure     1. Checks on xml file  &set optiona=build-sfm2xml-v3 &set option1=dict-xmlchecks
echo                                               2. Rerun Extra Transforms           &set option2=build-extra-transforms.cmd
echo        B. Make pre lex files            &set optionb=build-prelex
echo        C. Make Lexicon            &set optionc=build-lex
echo        D. Make Indexes and search JS           &set optionD=build-index
echo[
echo        E. Make all            &set optionE=build-all
echo[
echo        M. More . . .     &set optionm=:menu2
echo        N. Start Pub menu &set optionn=pub %iso% commonmenu
echo[
echo        Debug options to turn echo on or off
echo        O. Debug on             &set optiono=build-func debug on
echo        P. Debug off            &set optionp=build-func debug off
echo[
echo        X. Exit batch menu              &set optionq=:myexit
echo[
:: The menuoptions variable reflects what is in the letter choices above.
set menuoptions=0 1 2 a b c d e m n o p x 
call :menuchoice
if '%choice%' == 'x' exit /b %errorlevel%
goto menu1
goto :eof

:menu2
echo off
echo %time%
echo        2. Make xslt            &set option2=build-xslt-v2
echo        3. Test xslt            &set option3=test_xslt


echo[
echo        Unimplimented build tools
echo        G. Make advanced search            &set optiong=build-advsearch
echo        H. Make browse pages                &set optionh=build-browse
echo[
echo        R. Return to main menu &set optionr=:menu1
:: The menuoptions variable reflects what is in the letter choices above.
set menuoptions=2 3 4 g h r x
call :menuchoice
if '%choice%' == 'x' exit /b %errorlevel%
goto menu2
goto :eof

:menuchoice
:: SET /P prompts for input and sets the variable to whatever the user types
SET Choice=
SET /P Choice=Type the letter and press Enter: 
:: The syntax in the next line extracts the substring
:: starting at 0 (the beginning) and 1 character long
IF NOT '%Choice%'=='' SET Choice=%Choice:~0,1%

echo[
:: Loop to evaluate the input and start the correct process.
:: the following line processes the choice
FOR /D %%c IN (%menuoptions%) DO call :menueval %%c 
::goto :%menuname%
goto:eof

:menueval
:: run through the choices to find a match then calls the selected option
set let=%~1
set option=option%let%
:: /I makes the IF comparison case-insensitive
::IF /I '%Choice%'=='q' exit /b
IF /I '%Choice%'=='%let%' call %%%option%%% %iso%
goto:eof

:setup
set iso=
if "%~1" == "" (
SET proj=
SET /P Choice=Enter iso code: 
) else (
set proj=%1
)

set basepath=%cd%

echo =============================================
echo Setup %proj% variables
if exist var\%proj%.cmd (
call var\%proj%.cmd 
) else (
call :novarfile %~1
)
mkdir log
set logtemp=log
call build-func setuplog
call :dictvar
call :checks
set logtemp=
echo --------------------------------------------
goto:eof

:dictvar
:: some localization may be needed for these variables. 
:: all important tools are on the path with the exception of Saxon9
set java=java
set saxon9=C:\Program Files (x86)\Kernow\lib\saxon9.jar
set ccw32=ccw32
set cctparam=-u -b -q -n
set cctpath=scripts\cct
set xsltpath=scripts\xslt
set countfields=check-count-fields.xslt
set localhostpath=%htmlpath%
set csplit=csplit
set sed=sed
set sort=sort
set uniq=uniq
set charcountcct=char-count.cct
set barcodestoxml=inline2xml.cct
set fsprojectpath=%projectpath:\=/%
set varfile=setup\default-setup-%type%.TXT
set binmay=C:\Program Files (x86)\bin\binmay.exe
set unicodeccount=C:\Program Files (x86)\bin\UnicodeCCount.exe
set removelist=%basepath%\%projectpath%\setup\fields_to_remove.txt
set setuppath=%basepath%\%projectpath%\setup\
set xmlpath=%basepath%\%projectpath%\xml
goto:eof

:checks
:: create directories if not exist
echo Running checks for neccessary files and directoriesS
echo   basepath = %basepath%
echo   projectpath = %projectpath%
call :checkdir %projectpath%\log
call :checkdir %projectpath%\checks
call :checkdir %projectpath%\checks\fields\
call :checkdir %projectpath%\xml
call :checkdir %projectpath%\setup

:: make localhost path
call :checkdir %localhostpath%

:: make localhost subpaths
call :checkdir %localhostpath%\index
call :checkdir %localhostpath%\lexicon
call :checkdir %localhostpath%\common

:: make sure there are setup files available
call :ifnotcopy "%basepath%\%projectpath%\setup\extra-tasks.txt" "%basepath%\setup\default-plb\*.*" "%basepath%\%projectpath%\setup"
call :ifnotcopy  "%basepath%\%cctpath%\%iso%.cct" "%cctpath%\iso.cct" 

:: copy localhost files   \index.html
call :ifnotcopy "%localhostpath%\index.html" "shells\ver2\index.html"
call :ifnotcopy "%localhostpath%\common\find.html" "shells\ver2\common\*.*" "%localhostpath%\common"
call :ifnotcopy "%projectpath%\%iso%.xslt" "%xsltpath%\iso.xslt"

:: Generate langs.js file
set outfile=%localhostpath%\common\langs.js
if not exist "%outfile%" (
call build-func buildlangjs
echo build-func buildlangjs
echo build-func buildlangjs>>%logfile%
) else (
echo . . . Found! langs.js
)

set gt=^>
set lt=^<
goto:eof

:novarfile
call :samplevarfile
call :clearlangvar
set iso=%proj%

echo What is the ISO code for the language?              default iso=%iso%
SET /P iso=Press [Enter] for default iso code or type alternate: 
set type=plb
echo[
echo What sfm schema was used?                        default db type=%type%
SET /P type=Press [Enter] for default iso code or type alternate (i.e. mdf):
set projectpath=data\%iso%
echo[
echo What is the relative path?    default project path=%projectpath%
SET /P projectpath=Press [Enter] for default iso code or type alternate: 
SET /P source=Enter source file name without path: 
SET /P langname=Enter vernacular language name: 
SET /P natlang=Enter National language name if used/needed: 
SET /P reglang=Enter Regional language name if used/needed: 
SET /P reg2lang=Enter second Regional language name if used/needed: 
SET /P reg3lang=Enter third Regional language name if used/needed: 
rem SET /P labelname=Enter name to use to tag entries ie Sinama for Sama Sibutu: 
SET /P separator=Enter separator for multiple entry fields: 
set prog=prog
echo[
echo Where will the publication go?  default publication location =%prog%
SET /p prog=Press [Enter] for default publication location or type alternate (i.e. online):
if "%prog%" == "prog" set prog2=works

if "%prog%" == "online" set prog2=%prog%

set intropage=%prog2%-%iso%.html
echo[
echo What is the name of the intro page?   default page name=%intropage%
SET /P intropage=Press [Enter] for default introduction page or type alternate:
SET /P title=Enter title of dictionary (usually Language Name Dictionary):
SET htmlpath=D:\All-SIL-PLB\WebMaster\plb-www\%prog%\%iso%\dict
echo[
echo What is the output path? default path=%htmlpath%
SET /P htmlpath=Press [Enter] for default html path or type alternate:
echo[
echo Custom collation settings. use defaults
SET /P set collationname=Enter collation name if needed or leave blank for default collation:
SET /P set translateaccents=Leave blank for default (yes)
SET /P set customfind=Find string like ng to change to eng for sorting:
SET /P set customreplace=Replace string for sorting:
echo[
set write=y
set /P write=Do you want to write this information to a file for reuse? y or n:
if "%write%"=="y" call:writevarfile
call:eof

:writevarfile
set outfile=var\%iso%.cmd
echo :%iso%>%outfile%
echo set iso=%iso%>>%outfile%
echo set type=%type%>>%outfile%
echo set projectpath=%projectpath%>>%outfile%
echo set source=%source%>>%outfile%
echo set langname=%langname%>>%outfile%
echo set natlang=%natlang%>>%outfile%
echo set reglang=%reglang%>>%outfile%
echo set reg2lang=%reg2lang%>>%outfile%
echo set reg3lang=%reg3lang%>>%outfile%
echo set labelname=%labelname%>>%outfile%
echo set splitseparator=%splitseparator%>>%outfile%
echo set intropage=%intropage%>>%outfile%
echo set title=%title%>>%outfile%
echo set htmlpath=%htmlpath%>>%outfile%
echo set xslttemplate=%iso%.xslt>>%outfile%
echo :: collation settings for costom collation>>%outfile%
echo set collationname=%collationname%>>%outfile%
echo set translateaccents=%translateaccents%>>%outfile%
echo set customfind=%customfind%>>%outfile%
echo set customreplace=%customreplace%>>%outfile%
goto:eof

:clearlangvar
SET iso=
SET type=
SET projectpath=
SET source=
SET langname=
SET natlang=
SET reglang=
SET reg2lang=
SET reg3lang=
SET labelname=
SET splitseparator=
SET intropage=
goto:eof

:samplevarfile
echo  var\%proj%.cmd does not exist.
echo Create this file in the following form
echo :iso
echo set iso=iso
echo set type=plb
echo set projectpath=data\iso
echo set source=iso-di.txt
echo set langname=Tagbanwa
echo set natlang=
echo set reglang=
echo set labelname=Tagbanwa
echo set splitseparator=;
echo set intropage=works-iso.html
echo set title=Ibatan - English Dictionary
echo set htmlpath=D:\All-SIL-PLB\WebMaster\plb-www\online\%iso%\dict6
echo :: collation settings for costom collation
echo set collationname=
echo set translateaccents=
echo set customfind=
echo set customreplace=
echo[
echo[
goto:eof


echo[
goto:eof

:setupfile
set report=Setup file %~1 copied if needed
copy "%basepath%\setup\default-%type%\%~1" "%basepath%\%projectpath%\setup"
echo copy "%basepath%\setup\default-%type%\%~1" "%basepath%\%projectpath%\setup"
goto:eof

:checkdir
set report=Checking dir %~1 
if exist "%~1"  (
          echo . . . Found! %~1
    ) else (
          echo . . . not found. %~1  
          mkdir "%~1" 
          echo mkdir "%~1" 
)
goto:eof


:debugsettings
:: Adjust report back levels 
:: Lev1-5 allows adjusting globally what is echoed back while processing
:: Set to :: to turn off reporting levels if all is going well.
:: Leave lev1 blank unless on debug level 0
set lev1=
:: Leave lev2 blank for good general reporting for debuglevel 1
set lev2=
:: Change to blank if you want more detailed progress reporting.
set lev3=
set lev4=::
set lev5=::
goto:eof

:getiso
SET proj=
SET /P Choice=Enter iso code: 
goto:eof

:test_xslt
echo on
set report=Index Sort and group
set outfile=data\Yakan\xml\index-ver-joined.xml
set script=%xsltpath%\_test-lower-remove-accents.xslt
set infile=%outfile%
set outfile=%basepath%\%projectpath%\xml\index-%index%-grouped.xml
if exist %basepath%\%projectpath%\setup\collation.txt (
call file2uri %basepath%\%projectpath%\setup\collation.txt
) else (
set uri=
)

::set param=customfind=%transfind% customreplace=%transreplace% sort=%sort%
::set param=collation=http://saxon.sf.net/collation?rules="%collation%"
set param=translateaccents=%translateaccents% customfind=%transfind% customreplace=%transreplace% collationtexturi=%uri%

call build-func xslt


:ifnotcopy
if not exist %~1 (
    if "%~3" == "" (
        copy %~2 %~1
        echo copy %~2 %~1
        echo copy %~2 %~1>>%logfile%
    ) else (
        copy %~2 %~3
        echo copy %~2 %~3
        echo copy %~2 %~3>>%logfile%
    )
) else (
      echo . . . Found! %~1
)
goto :eof

:myexit
exit /b %errorlevel%
:done