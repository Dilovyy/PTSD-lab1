#FROM mcr.microsoft.com/dotnet/sdk:8.0
#WORKDIR /app

#COPY DumbApplication/ ./

#RUN dotnet test TestProject/TestProject.csproj --verbosity normal



FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY DumbApplication/ ./
RUN dotnet restore
RUN dotnet test TestProject/TestProject.csproj --verbosity normal
RUN dotnet publish DumbApplication/DumbApplication.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "DumbCore.dll"]



