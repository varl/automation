# Build it

```bash
docker build -t mergetx .
```

# Configure it

## Environment

A template for configurable env variables in `env-template`.

```bash
tee ./env <<EOF
GITHUB_TOKEN={add github token to user}
EOF
```

## Repos

Add the name of the repo to `./repo-list.sh`.

# Run it

```bash
# with master as base
docker run --env-file=env mergetx

# with many bases
docker run --env-file=env mergetx master v33 v32 v31 v30 v29 2.33 2.32 2.31 2.30 2.29
```

# ToDo

- [ ] Dynamically get a list of repos that has translations
-   -   From Transifex?
-   -   From GitHub?
