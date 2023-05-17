APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=vadymhula
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=amd64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format get
	CGO_ENABLED=0 GOOS=${TARGETOS} GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/vhula/kbot/cmd.appVersion=${VERSION}

linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/vhula/kbot/cmd.appVersion=${VERSION}

windows:
	CGO_ENABLED=0 GOOS=windows GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/vhula/kbot/cmd.appVersion=${VERSION}

darwin:
	CGO_ENABLED=0 GOOS=darwin GOARCH=${TARGETARCH} go build -v -o kbot -ldflags "-X="github.com/vhula/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} --build-arg TARGETARCH=${TARGETARCH} --build-arg TARGETOS=${TARGETOS}

tag: image
	docker tag ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH} gcr.io/repo-10-usd/${APP}:${VERSION}-${TARGETARCH}

push:
	docker push gcr.io/repo-10-usd/${APP}:${VERSION}-${TARGETARCH}

clean:
	rm -f kbot
	docker rmi ${REGISTRY}/${APP}:${VERSION}-${TARGETARCH}