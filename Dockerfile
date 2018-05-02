FROM golang

# Fetch dependencies
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# Add project directory to Docker image.
ADD . /go/src/github.com/valentin2105/Hello

ENV USER valentin
ENV HTTP_ADDR :8888
ENV HTTP_DRAIN_INTERVAL 1s
ENV COOKIE_SECRET uXlcW8PBsWz8tLnK

# Replace this with actual PostgreSQL DSN.
#ENV DSN postgres://valentin@localhost:5432/Hello?sslmode=disable

WORKDIR /go/src/github.com/valentin2105/Hello

RUN dep ensure && go build

EXPOSE 8888
CMD ./Hello
