FROM mcr.microsoft.com/dotnet/sdk:7.0

# TODO: figure out how to build .dll artifact and run it, so that
#       in prod there's no compilation needed at container start.
#       Benefits: faster start time, less risk in starting the container
#                 test files & plain text code not present in prod.
RUN useradd -m app

WORKDIR /app

COPY . /app
RUN chown -R app:app /app/

USER app

CMD dotnet run --project src/HelloWorldApi --urls=http://0.0.0.0:5000
