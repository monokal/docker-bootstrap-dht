# Docker DHT bootstrap server
A Docker Image containing the official [BitTorrent DHT bootstrap][1] server which BitTorrent clients can use as an introducer to a DHT network, such as the public ones running at `router.utorrent.com` and `router.bittorrent.com`.

#### Running a DHT bootstrap server
```sh
docker run -d \
    --restart=unless-stopped \
    -p 6881:6881 \
    --name bootstrap-dht \
    monokal/bootstrap-dht:latest \
    0.0.0.0 \
    --threads 1 \
    --nodes 10 \
    --ping-queue 10
```

Further details on the available `bootstrap-dht` parameters can be found [here][1].

#### Building the Docker Image
```sh
docker build -t monokal/bootstrap-dht:latest .
```
#### Contributions
To contribute to this Docker Image, just open a [pull request][2]. To contribute to the `bootstrap-dht` source, head over to the [official repo][1].

[1]: https://github.com/bittorrent/bootstrap-dht
[2]: https://github.com/monokal/docker-bootstrap-dht/pulls
