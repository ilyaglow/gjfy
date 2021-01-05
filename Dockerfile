FROM golang:latest as builder

ENV CGO_ENABLED=0

COPY . /gjfy

WORKDIR /gjfy

RUN go build -ldflags="-s -w" -o /bin/gjfy

FROM alpine:latest

RUN adduser -D gjfy

COPY --from=0 /bin/gjfy /gjfy
COPY --from=0 /gjfy/custom.css /custom.css
COPY --from=0 /gjfy/logo.png /logo.png

USER gjfy

ENTRYPOINT ["/gjfy"]
CMD ["-allow-anonymous"]
