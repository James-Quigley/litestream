FROM golang:1.15 as build

WORKDIR /build

COPY . .

RUN GOOS=linux GOARCH=amd64 GCO_ENABLED=0 go build -v -o dist/litestream -ldflags '-extldflags "-static"' ./cmd/litestream

FROM scratch

COPY --from=build /build/dist/litestream /litestream

ENTRYPOINT ["/litestream"]
