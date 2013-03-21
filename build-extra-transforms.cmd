:main
call build-func setdebug
call build-func setuplog
echo =============================================
set outfile=%basepath%\%projectpath%\xml\%iso%-exGroup.xml
call build-func log "build-extra-changes"
call build-func mixedtasks %basepath%\%projectpath%\setup\extra-tasks.txt "Extra tasks"
call build-func lasttransform %iso%-a.xml 
