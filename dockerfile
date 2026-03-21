FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
#COPY ["DumbApplication/DumbApplication/DumbApplication.csproj",  "DumbApplication/"]
COPY DumbApplication/ ./
RUN dotnet restore "DumbApplication/DumbApplication.csproj"

RUN dotnet build "DumbApplication/DumbApplication.csproj" -c Release -o /app/build

# Use the build stage to run tests
FROM build AS test
#WORKDIR /src/tests
# Assuming you have a test project named MyDockerApp.Tests.csproj in a 'tests' folder
#COPY ["TestProject/TestProject.csproj", "tests/"]
#COPY . .
RUN dotnet test "TestProject/TestProject.csproj"

# Use a smaller runtime image for the final publish stage
FROM build AS publish
RUN dotnet publish "DumbApplication/DumbApplication.csproj" -c Release -o /app/publish --no-build

# Use the ASP.NET Core runtime image as the final stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DumbApplication.dll"]



