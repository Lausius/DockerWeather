FROM mcr.microsoft.com/dotnet/core/sdk:2.2 AS build-env
WORKDIR /app

COPY DockerWeather/DockerWeather.csproj .
RUN dotnet publish "DockerWeather.csproj" -c Release -o out

FROM mcr.microsoft.com/dotnet/core/aspnet:2.2
WORKDIR /app
COPY --from=build-env /app/DockerWeather/out .

ENTRYPOINT ["dotnet", "DockerWeather.dll"]