FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

COPY ["DumbApplication/TestProject/TestProject.csproj", "DumbApplication/TestProject/"]
COPY ["DumbApplication/Core/Core.csproj",                 "DumbApplication/Core/"]
RUN dotnet restore "DumbApplication/TestProject/TestProject.csproj"

COPY DumbApplication/ ./DumbApplication/

FROM build AS test
RUN dotnet test "DumbApplication/TestProject/TestProject.csproj" \
    --verbosity normal \
    --results-directory /app/TestResults
