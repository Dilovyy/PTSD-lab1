FROM mcr.microsoft.com/dotnet/sdk:8.0
WORKDIR /app

COPY DumbApplication/ ./

RUN dotnet test DumbApplication/TestProject/TestProject.csproj --verbosity normal
