#FROM mcr.microsoft.com/dotnet/sdk:8.0
#WORKDIR /app

#COPY DumbApplication/ ./

#RUN dotnet test TestProject/TestProject.csproj --verbosity normal



FROM mcr.microsoft.com/dotnet/sdk:9.0@sha256:3fcf6f1e809c0553f9feb222369f58749af314af6f063f389cbd2f913b4ad556 AS build
WORKDIR /app
COPY DumbApplication/ ./
RUN dotnet restore
RUN dotnet test TestProject/TestProject.csproj --verbosity normal
RUN dotnet publish DumbApplication/DumbApplication.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:9.0@sha256:b4bea3a52a0a77317fa93c5bbdb076623f81e3e2f201078d89914da71318b5d8
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "DumbCore.dll"]



