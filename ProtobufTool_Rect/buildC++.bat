@echo off
for /r %%i in (*.proto) do (          
    echo %%~ni.proto
    protoc.exe  --cpp_out=./C++protocs ./%%~ni.proto
)
pause