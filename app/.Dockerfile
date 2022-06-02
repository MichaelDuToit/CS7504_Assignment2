FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ["./Assignment2WebApp.cproj/Assignment2WebApp.cproj", ""]
RUN dotnet restore "./Assignment2WebApp.cproj/Assignment2WebApp.cproj"
COPY ..
WORKDIR "/src/."
RUN dotnet build "Assignment2WebApp.cproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Assignment2WebApp.cproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Assignment2WebApp.dll"]