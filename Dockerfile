FROM golang:1.10.1-stretch

RUN go get -u github.com/golang/dep/cmd/dep \
    && mkdir -p /go/src/github.com/valentin2105/Hello

ADD Gopkg.toml /go/src/github.com/valentin2105/Hello
ADD Gopkg.lock /go/src/github.com/valentin2105/Hello

WORKDIR /go/src/github.com/valentin2105/Hello

RUN dep ensure --vendor-only
 
ADD . /go/src/github.com/valentin2105/Hello
 
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o Hello -v                                       
#########################################################################
FROM scratch
 
WORKDIR /root/
 
COPY --from=0 /go/src/github.com/valentin2105/Hello/Hello .
COPY --from=0 /go/src/github.com/valentin2105/Hello/templates/ templates/
COPY --from=0 /go/src/github.com/valentin2105/Hello/static/ static/
 
EXPOSE 8888
CMD ./Hello
