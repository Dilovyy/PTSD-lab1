FROM mcr.microsoft.com/dotnet/framework/sdk:4.8
WORKDIR /app

COPY DumbApplication/ ./

RUN dotnet test DumbApplication/TestProject/TestProject.csproj --verbosity normal
