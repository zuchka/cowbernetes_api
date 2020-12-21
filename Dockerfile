FROM alpine:latest

WORKDIR /usr/src/app

COPY . .

RUN apk add elixir

RUN mix local.hex --force

RUN mix deps.get

EXPOSE 9090

ENTRYPOINT ["mix", "run", "--no-halt"]
