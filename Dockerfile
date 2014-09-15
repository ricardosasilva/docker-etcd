FROM dockerfile/supervisor

# Let's install go just like Docker (from source).

RUN apt-get update -q

RUN DEBIAN_FRONTEND=noninteractive apt-get install -qy build-essential curl git

RUN curl -s https://storage.googleapis.com/golang/go1.3.src.tar.gz | tar -v -C /usr/local -xz

RUN cd /usr/local/go/src && ./make.bash --no-clean 2>&1

ENV PATH /usr/local/go/bin:$PATH

RUN mkdir /opt/etcd/ -p

RUN curl -s -L https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz | tar -v -C /opt/etcd -zx

RUN ln -s /opt/etcd/etcd-v0.4.6-linux-amd64/etcd /usr/local/bin/
RUN ln -s /opt/etcd/etcd-v0.4.6-linux-amd64/etcdctl /usr/local/bin/

ADD run.sh /usr/local/bin/run

CMD ["/bin/sh", "-e", "/usr/local/bin/run"]

EXPOSE 4001 7001
