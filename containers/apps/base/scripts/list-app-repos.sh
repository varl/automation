#!/usr/bin/env bash

gh repo list dhis2 --no-archived --limit 200 \
    | grep '.*\-app' \
    | cut -f 1
