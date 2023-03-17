FROM golang:1.20 AS builder

RUN mkdir -p /app
WORKDIR /app

ADD . /app
RUN go get -v

RUN GOARCH=amd64 GOOS=linux CGO_ENABLED=0 go build -o prometheus-status-pusher main.go

FROM scratch

COPY --from=builder /app/prometheus-status-pusher /prometheus-status-pusher

ENTRYPOINT [ "/prometheus-status-pusher" ]
