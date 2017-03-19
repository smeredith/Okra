@SETLOCAL
@ECHO OFF
@IF NOT EXIST .build mkdir .build
cd .build

echo ******************** cmake ********************
cmake -Werror=dev -Werror=deprecated "%~dp0"
IF ERRORLEVEL 1 goto :EOF

echo ******************** build ********************
cmake --build . -- /verbosity:minimal
IF ERRORLEVEL 1 goto :EOF

echo ******************** ctest ********************
ctest
IF ERRORLEVEL 1 goto :EOF
