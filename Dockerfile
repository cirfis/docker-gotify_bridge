FROM golang:buster as build-env
RUN go get github.com/DRuggeri/alertmanager_gotify_bridge \
	&& go install github.com/DRuggeri/alertmanager_gotify_bridge

FROM ubuntu
COPY --from=build-env /go/bin/alertmanager_gotify_bridge /

EXPOSE 9877

ENTRYPOINT /alertmanager_gotify_bridge --port=9877 --gotify_endpoint="http://127.0.0.1:8600/message"
