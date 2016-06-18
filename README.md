# Docker DHT bootstrap server
A Docker Image containing the official [BitTorrent DHT bootstrap][1] server which BitTorrent clients can use as an introducer to a DHT network, such as the public ones running at `router.utorrent.com` and `router.bittorrent.com`.

#### Running a DHT bootstrap server
```sh
docker run -d \
    --restart=unless-stopped \
    -p 6881:6881 \
    --net=host \
    --name bootstrap-dht \
    monokal/bootstrap-dht:latest \
    0.0.0.0 \
    --threads 1
```

Further details on the available `bootstrap-dht` options can be found [here][1].

#### Testing
A `test_dht.py` script can be found in the [bootstrap-dht repo][1].
```sh
./test_dht.py 0.0.0.0 6881

=== TESTING DHT PING ===
ping 69 -> 0.0.0.0:6881
<--  {'y': 'r', 'ip': '\x7f\x00\x00\x01\x90t', 'r': {'id': 'HgNg#\x94\x82\xda\xbc\xec4S\xff\x1f\x95x\xfe\xec\xbd\x00'}, 't': '69'}
*** Passed ***
find_node 209 -> 0.0.0.0:6881
<--  {'y': 'r', 'ip': '\x7f\x00\x00\x01\x90t', 'r': {'nodes': '', 'id': 'HgNg#\x94\x82\xda\xbc\xec4S\xff\x1f\x95x\xfe\xec\xbd\x00'}, 't': '209'}
received 0 nodes
*** Passed ***
```

#### Building the Docker Image
```sh
docker build -t monokal/bootstrap-dht:latest .
```
#### Contributions
To contribute to this Docker Image, just open a [pull request][2]. To contribute to the `bootstrap-dht` source, head over to the [official repo][1].

[1]: https://github.com/bittorrent/bootstrap-dht
[2]: https://github.com/monokal/docker-bootstrap-dht/pulls
