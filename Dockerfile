FROM golang:1.14-alpine AS builder

RUN apk add --no-cache build-base 

COPY . /home
WORKDIR /home

ARG version
ARG buildnum

RUN go build -v -mod=vendor -o go-sqlite3-sample-pipeline

###########
FROM alpine

WORKDIR /home

COPY --from=builder /home/go-sqlite3-sample-pipeline .

ENTRYPOINT ["./go-sqlite3-sample-pipeline"]
