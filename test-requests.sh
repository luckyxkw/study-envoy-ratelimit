#!/bin/bash
set -x

echo "Requests with token=1..."
curl "http://localhost:8888/test?token=1" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=1" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=1" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=1" -s -o /dev/null -w "%{http_code}\n"

echo "Requests with token=2..."
curl "http://localhost:8888/test?token=2" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=2" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=2" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=2" -s -o /dev/null -w "%{http_code}\n"

echo "Requests with token=3..."
curl "http://localhost:8888/test?token=3" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=3" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=3" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=3" -s -o /dev/null -w "%{http_code}\n"

echo "Others"
curl "http://localhost:8888/test?token=4" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=5" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test?token=6" -s -o /dev/null -w "%{http_code}\n"
curl "http://localhost:8888/test" -s -o /dev/null -w "%{http_code}\n"