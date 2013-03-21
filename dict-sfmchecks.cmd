call build-func setdebug
call build-func setuplog
echo =============================================
call build-func log "dict-sfmchecks.cmd"

:: make a character count by cct
set report=Counted characters
set infile=%basepath%\%projectpath%\%source%
set outfile=%basepath%\%projectpath%\checks\char-count.txt
set script=%charcountcct%
call build-func ccw

:: do unicode character count to check if unicode already
set report=Counted Unicode characters
set infile=%basepath%\%projectpath%\%source%
set outfile=%basepath%\%projectpath%\checks\char-count-unicode1.txt
call build-func unicodecount

:: count bar codes 
set report=Count bar codes
set infile=%basepath%\%projectpath%\%source%
set outfile=%basepath%\%projectpath%\checks\count-bar-codes.txt
set script=count4-bar-code.cct
call build-func ccw

:: list repeated bar codes 
set report=List repeated bar codes
set infile=%basepath%\%projectpath%\%source%
set outfile=%basepath%\%projectpath%\checks\repeated-bar-codes.txt
set script=checks-multibarcodes.cct
call build-func ccw

:: Count fields
set infile=%projectpath%\%source%
set outfile=%projectpath%\checks\temp1.txt
sed -e "s/\\_.*//" -e "s/ .*$//" -e "s/.\n.\n/\r\n/" %infile%>%outfile%
IF %errorlevel% == 0 call build-func log "Field names raw data generated"

set infile=%outfile%
set outfile=%projectpath%\checks\temp2.txt
sort %infile%>%outfile% 
IF %errorlevel% == 0 call build-func log "Field names raw data sorted"

set infile=%outfile%
set outfile=%projectpath%\checks\fieldcount.txt
uniq -c "%infile%" "%outfile%"
IF %errorlevel% == 0 call build-func log "Field names counted"

set infile=%projectpath%\checks\temp2.txt
set outfile=%projectpath%\checks\fieldlist.txt
::uniq "%infile%" "%outfile%"
::IF %errorlevel% == 0 call build-func log "Field list created"

:: Count empty fields
::set action=sed -e "s/\\_.*//" -e "s/\\[^ ]+ .+*$//" -e "s/.\n.\n/\r\n/" %projectpath%\%source%
set outfile=%projectpath%\checks\temp3.txt
set infile=%projectpath%\%source%
egrep "\\.{0,3}$" %infile%>%outfile%
IF %errorlevel% == 0 call build-func log "Empty fields raw data"

set infile=%outfile%
set outfile=%projectpath%\checks\temp4.txt
sort %infile%>%outfile% 
IF %errorlevel% == 0 call build-func log "Empty fields raw data sorted"


set infile=%outfile%
set outfile=%projectpath%\checks\emptyfield.txt
uniq -c %infile% %outfile%
IF %errorlevel% == 0 call build-func log "Empty fields counted"

:: Part of speech
set infile=%projectpath%\%source%
set outfile=%projectpath%\checks\tempps1.txt
egrep "\\ps "  %infile%>%outfile%

set infile=%outfile%
set outfile=%projectpath%\checks\tempps2.txt
sort %infile%>%outfile%

set infile=%outfile%
set outfile=%projectpath%\checks\pscount.txt
uniq -c "%infile%" "%outfile%"
IF %errorlevel% == 0 call build-func log "Part of speech unique fields counted"


del %projectpath%\checks\temp*.txt
IF %errorlevel% == 0 call build-func log "Deleted temporary file"
echo --------------------------------------------
cd "%basepath%"