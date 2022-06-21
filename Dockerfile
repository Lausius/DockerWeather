FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /app

# Copy csproj and restore as distinct layers
COPY DockerWeather/*.csproj .
RUN dotnet restore

# Copy everything else and build website
COPY DockerWeather/. .
RUN dotnet publish -c release -o /DockerWeather --no-restore

# Final stage / image
FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /DockerWeather
COPY --from=build /DockerWeather ./
ENTRYPOINT ["dotnet", "DockerWeather.dll"]