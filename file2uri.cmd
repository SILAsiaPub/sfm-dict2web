:file2uri
set uri%2=
set pathfile=%1
set numb=%2
set uri%numb%=file:///%pathfile:\=/%
set return=file:///%pathfile:\=/%
echo       uri%numb%=%return:~0,25% . . . %return:~-30%
echo       uri%numb%=%return%>>%logfile%
goto:eof