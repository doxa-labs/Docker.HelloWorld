FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["DoxaLabs.Docker.HelloWorld.csproj", ""]
RUN dotnet restore "./DoxaLabs.Docker.HelloWorld.csproj"
COPY . .
WORKDIR "/src/."
RUN dotnet build "DoxaLabs.Docker.HelloWorld.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "DoxaLabs.Docker.HelloWorld.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "DoxaLabs.Docker.HelloWorld.dll"]