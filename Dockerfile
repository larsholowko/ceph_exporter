FROM ubuntu:16.10
MAINTAINER Vaibhav Bhembre <vaibhav@digitalocean.com>

# BUILD
# docker build -t digitalocean/ceph_exporter .
# RUN
# docker run -v /etc/ceph:/etc/ceph -p=9128:9128 -it digitalocean/ceph_exporter

ENV GOPATH /go
ENV APPLOC $GOPATH/src/github.com/digitalocean/ceph_exporter

RUN apt-get update && apt-get install -y apt-transport-https

RUN apt-get update && \
    apt-get install -y golang git curl

RUN apt-get install -y --force-yes librados-dev librbd-dev

ADD . $APPLOC
WORKDIR $APPLOC
RUN go get -d && \
    go build -o /bin/ceph_exporter

EXPOSE 9128
ENTRYPOINT ["/bin/ceph_exporter"]
