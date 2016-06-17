# docker-bootstrap-dht
A Docker Image containing the official [BitTorrent DHT bootstrap][1] server which BitTorrent clients can use as an introducer to a DHT network, such as the public ones running at `router.utorrent.com` and `router.bittorrent.com`.

## Usage
### Run
```bash
docker run -d \
           --restart=unless-stopped \
           -p 6881:6881 \
           --name bootstrap-dht \
           monokal/bootstrap-dht:latest \
           --threads 1 \
           --nodes 10 \
           --ping-queue 10
```

Further details on the available `bootstrap-dht` parameters can be found [here][1].

### Build
docker build -t monokal/bootstrap-dht:latest .

[1]: https://github.com/bittorrent/bootstrap-dht "Official BitTorrent bootstrap-dht repo."
