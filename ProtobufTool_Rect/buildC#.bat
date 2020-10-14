
for /r %%i in (*.proto) do (          
    echo %%~ni.proto
    protoc.exe  --csharp_out=./C#protocs ./%%~ni.proto
    echo(protoc.exe  --csharp_out=./C#protocs ./%%~ni.proto)
)
pause