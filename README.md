# urbit-docker-compose

A self-contained urbit installation with nginx reverse proxy with certbot to fetch Let's Encrypt certificates.

[![awesome urbit badge](https://img.shields.io/badge/~-awesome%20urbit-lightgrey)](https://github.com/urbit/awesome-urbit)

# Requirements

 - docker
 - docker-compose
 - A DNS A record

# Usage

Assuming a DNS entry for foo.example.com exists, on a machine servicing the IP address (with firewall and routing for ports 80, 443 and 32123)

To start a disconnected dev ship:

```
./start.sh foo.example.com -F zod
``` 

To start a comet

```
./start foo.example.com -C my-comet
```

To boot a planet:

_Sorry, this needs to be done by hand once...._

Add `- ./my-planet-key:/master-key` to `.services.volumes` in assets/docker-compose.yaml:

```
        volumes:
          # Need the key file once in order to boot ship
          - ./my-planet-key:/master-key
          - urbit-data:/urbit
        ports:
```

Now boot the ship using the master key. The planet name needs to match the address of the master-key and must be a valid urbit address

```
./start.sh foo.example.com -k /master-key bittel-bottel
```

Once the ship boots, the master key can be removed from the assets/docker-compose.yaml and deleted

```
        volumes:
          # Master key removed
          - urbit-data:/urbit
        ports:
```

The ship can be booted without a key:

```
./start.sh foo.example.com bittel-bottel
```

# Thanks

Urbit docker container from https://github.com/asssaf/urbit-docker
