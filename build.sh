#!/usr/bin/env sh
docker build -t ndrvtl/build-et .
id=$(docker create ndrvtl/build-et)
docker cp $id:/opt/deploy .
