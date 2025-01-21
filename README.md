# study-envoy-ratelimit

Study Envoy Proxy's rate limiting with some example environment setup

## local rate limit demo

To start the demo environment:

```
docker-compose -f docker-compose-local-ratelimit.yml up --build --remove-orphans
```

Run `test-local-ratelimit.sh` to send some test requests. We can see the fourth requests for token=1
or token=2 are rejected. And for other requests, only one request is allowed.

We can zoom into the local rate limit definition to see why envoy behaves in this way:

```
                  - name: envoy.filters.http.local_ratelimit
                    typed_config:
                      "@type": type.googleapis.com/envoy.extensions.filters.http.local_ratelimit.v3.LocalRateLimit
                      stat_prefix: "local_rate_limit"
                      token_bucket:
                        max_tokens: 1
                        tokens_per_fill: 1
                        fill_interval: "60s"
                      filter_enabled:
                        default_value:
                          numerator: 100
                          denominator: HUNDRED
                      filter_enforced:
                        default_value:
                          numerator: 100
                          denominator: HUNDRED
                      always_consume_default_token_bucket: false
                      descriptors:
                        - entries:
                            - key: token
                              value: "1"
                          token_bucket:
                            max_tokens: 3
                            tokens_per_fill: 3
                            fill_interval: "60s"
                        - entries:
                            - key: token
                              value: "2"
                          token_bucket:
                            max_tokens: 3
                            tokens_per_fill: 3
                            fill_interval: "60s"
                      rate_limits:
                        - actions:
                            - query_parameters:
                                query_parameter_name: "token"
                                descriptor_key: "token"
```

Here we defined three token buckets: 1 req/min for global, 3 req/min for token=1, and 3 req/min for token=2. The token descriptor uses the value in request query param `token`. When we send requests like /test?token=1 or /test?token=2, tokens in their corresponding bucket are consumed. For other requests, tokens in global bucket is consumed.

Since local rate limit [does not support dyanmic token bucket](https://github.com/envoyproxy/envoy/issues/19895#issuecomment-1051136575), we have to define all possible descriptor values in the config. This is inpractical for cases like "limiting x rps for each distinct user". Thus global rate limiting is here to play the role.

## global rate limit demo

## references

- https://github.com/envoyproxy/ratelimit
- https://www.envoyproxy.io/docs/envoy/latest/
