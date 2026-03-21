FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
COPY ["WinFormsApp1/WinFormsApp1/WinFormsApp1.csproj",  "WinFormsApp1/WinFormsApp1/"]
COPY ["WinFormsApp1/ClassLibrary1/ClassLibrary1.csproj",             "WinFormsApp1/ClassLibrary1/"]
COPY ["WinFormsApp1/TestProject/TestProject.csproj",       "WinFormsApp1/TestProject/"]

RUN dotnet restore "WinFormsApp1/WinFormsApp1/WinFormsApp1.csproj"

COPY WinFormsApp1/ ./
WORKDIR ./WinFormsApp1
RUN dotnet build "WinFormsApp1/WinFormsApp1.csproj" -c Release -o /app/build

FROM build AS test
RUN dotnet test "TestProject/TestProject.csproj"

FROM build AS publish
RUN dotnet publish "WinFormsApp1/WinFormsApp1.csproj" -c Release -o /app/publish --no-build

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "WinFormsApp1.dll"]

