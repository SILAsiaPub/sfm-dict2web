:: Build-all build whole project
call build-sfm2xml-v3 %proj%
call build-prelex %proj%
call build-lex %proj%
call build-index %proj%
::call build-find %proj%
