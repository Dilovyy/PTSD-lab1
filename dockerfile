FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ["WinFormsApp1/ClassLibrary1/ClassLibrary1.csproj",    "WinFormsApp1/ClassLibrary1/"]
COPY ["WinFormsApp1/TestProject/TestProject.csproj",        "WinFormsApp1/TestProject/"]

RUN dotnet restore "WinFormsApp1/TestProject/TestProject.csproj"

COPY WinFormsApp1/ ./WinFormsApp1/

RUN dotnet test "WinFormsApp1/TestProject/TestProject.csproj" \
    --verbosity normal \
    --results-directory /app/TestResults
