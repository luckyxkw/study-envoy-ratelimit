#!/bin/bash
set -x

curl "http://localhost:8888/test?token=1"
curl "http://localhost:8888/test?token=1"
curl "http://localhost:8888/test?token=1"
curl "http://localhost:8888/test?token=1" # limited

curl "http://localhost:8888/test?token=2"
curl "http://localhost:8888/test?token=2"
curl "http://localhost:8888/test?token=2"
curl "http://localhost:8888/test?token=2" # limited

curl "http://localhost:8888/test?token=3"
curl "http://localhost:8888/test?token=3" # limited
curl "http://localhost:8888/test?token=4" # limited
curl "http://localhost:8888/test" # limited