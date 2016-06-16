FROM       scratch
MAINTAINER Daniel Middleton <d@monokal.io>
ADD        dht-bootstrap dht-bootstrap
EXPOSE     6881
ENTRYPOINT ["/dht-bootstrap"]
