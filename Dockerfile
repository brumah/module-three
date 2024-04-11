FROM golang:1.22 as builder

WORKDIR /app

COPY go.* ./

RUN go mod download

COPY . ./

RUN CGO_ENABLED=0 GOOS=linux go build -v -o helloworld

FROM alpine:3

RUN apk add --no-cache ca-certificates

COPY --from=builder /app/helloworld /helloworld

CMD ["/helloworld"]
