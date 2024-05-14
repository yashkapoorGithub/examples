FROM golang:latest as builder

WORKDIR /go/src/github.com/kubernetes/examples/guestbook-go

COPY . .

RUN go mod download

RUN go build -o guestbook

FROM alpine:latest

COPY --from=builder /go/bin/guestbook /app/guestbook

CMD ["/app/guestbook"]
