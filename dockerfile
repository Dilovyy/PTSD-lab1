FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /app

COPY DumbApplication/ ./

RUN dotnet test TestProject/TestProject.csproj --verbosity normal
