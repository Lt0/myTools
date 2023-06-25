FROM golang:1.16 AS build-env
WORKDIR /app
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o aliddns

FROM ubuntu:22.04
RUN apt-get update && apt-get install -y ca-certificates
COPY --from=build-env /app/aliddns /aliddns
ENTRYPOINT [ "/aliddns" ]