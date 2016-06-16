# docker-bootstrap-dht
A Docker Image containing the official [BitTorrent DHT bootstrap](https://github.com/bittorrent/bootstrap-dht) server which BitTorrent clients can use as an introducer to a DHT network, such as the public ones running at `router.utorrent.com` and `router.bittorrent.com`.

The way DHT bootstrapping works is by storing all nodes in one circular buffer of (`IP`, `port`, `node-id`) triplets. In this circular buffer there are two cursors, one read cursor and one write cursor. When a `find_nodes` request comes in, we return the next few nodes (or so) under the read cursor and progresses it.

We remember the node that asked in a separate queue, and at a later time we ping it. If it responds, we add it at the write cursor and progresses it.

The transaction ID in the ping acts as a SYN-cookie. It's set to SHA1 (`secret`, `IP`, `port`, `node-id`) and only if the response matches the transaction ID will it be added to the list of nodes. The secret rotates periodically to avoid malicious nodes from inserting themselves without us pinging them.

In addition to this, nodes whose node ID don't match [the specification][1] will not be pinged. A node's external IP and port is always included in all responses.

[1]: http://libtorrent.org/dht_sec.html "BitTorrent DHT security extension."
