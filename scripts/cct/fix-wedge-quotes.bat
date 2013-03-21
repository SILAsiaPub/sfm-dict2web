set extin=%1
dir /b *.%extin%  >inlist.txt

FOR /F %%f IN (inlist.txt) DO call :cceach %%f
goto :eof

:cceach
set file=%~1
set name=%~n1
set extn=%~x1
set tempname=%name%.in
rename %file% 
ccs %param% -c unicode-mapin.cct %tempname% -o %file%
goto :eof
