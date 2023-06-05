# igraph-san

## Running

```sh
docker run --rm -ti --platform linux/amd64 ghcr.io/krlmlr/rigraph-san:main RDcsan -q -e 'library(igraph)'
```

### Mounting a local igraph clone

```sh
docker run --rm -ti --platform linux/amd64 -v $(pwd):/igraph ghcr.io/krlmlr/rigraph-san:main RDsan -q -e 'setwd("igraph"); source("test.R")'
```


## Setup notes

- On <https://github.com/krlmlr/igraph-san/settings/actions>, set "Workflow permissions" to "Rread and write permissions"

- On <https://github.com/krlmlr/igraph-san/pkgs/container/igraph-san>, link repository

- Per <https://stackoverflow.com/a/72585915/946850>, on <https://github.com/users/krlmlr/packages/container/igraph-san/settings>, add igraph-san repo and set access to "Write"
