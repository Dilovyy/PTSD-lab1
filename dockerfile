FROM mcr.microsoft.com/dotnet/framework/sdk:4.8
WORKDIR /app

COPY DumbApplication/ ./

RUN msbuild DumbApplication/DumbApplication.sln /p:Configuration=Release

RUN vstest.console.exe DumbApplication\TestProject\bin\Release\TestProject.dll