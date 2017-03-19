@SETLOCAL
@IF NOT EXIST .build mkdir .build
cd .build

cmake -Werror=dev -Werror=deprecated "%~dp0"
IF ERRORLEVEL 1 goto :EOF

cmake --build . -- /verbosity:minimal
IF ERRORLEVEL 1 goto :EOF

ctest
IF ERRORLEVEL 1 goto :EOF
