FROM golang:buster as build-env
LABEL org.opencontainers.image.source https://github.com/cirfis/docker-gotify_bridge

RUN go get github.com/DRuggeri/alertmanager_gotify_bridge \
	&& go install github.com/DRuggeri/alertmanager_gotify_bridge@latest

FROM ubuntu
COPY --from=build-env /go/bin/alertmanager_gotify_bridge /

EXPOSE 9877

ENTRYPOINT /alertmanager_gotify_bridge --port=9877 --gotify_endpoint="http://127.0.0.1:8600/message"
