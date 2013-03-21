call build-func setdebug
echo =============================================
echo build-xslt creates xslt if none exists
echo    Rename or delete file if you want a new one created.
call build-func setuplog


:: call functions
::call:prereq
call:checkwebsingle
call:checkprintstrict
echo --------------------------------------------
goto:done

:checkwebsingle
if not exist "%projectpath%\%iso%.xslt" (
goto :websingle

) else (
call build-func log "%iso%.xslt already exists." 
)


goto:eof

:websingle
:: build web single page xslt
set report=built web single page xslt
set infile=%basepath%\%projectpath%\checks\fields.xml
set outfile=%basepath%\%projectpath%\%iso%.xslt
set script=%basepath%\%xsltpath%\make-%type%-web-single-xslt.xslt
set param=langlabel=%langlabel%
call build-func xslt
goto:eof

:: Checking web single xslt
:checkprintstrict
if not exist "%projectpath%\%iso%-print-strict.xslt" (
goto:printstrict
) else (
call build-func log "%iso%-print-strict.xslt already exists." 
)


goto:eof

:printstrict
:: build print strict xslt
set report=built print strict xslt
set infile=%basepath%\%projectpath%\checks\fields.xml
set outfile=%basepath%\%projectpath%\%iso%-print-strict.xslt
set script=%basepath%\%xsltpath%\make-%type%-print-strict-xslt.xslt
set param=langlabel=%langlabel%
call build-func xslt
goto:eof
:: Start functions
:: Functions

:prereq
set report=Verified prerequisite files are already created
set action=if not exist "%projectpath%\%iso%-a.xml" call build-sfm2xml.cmd
call build-func action
goto:eof

:done
