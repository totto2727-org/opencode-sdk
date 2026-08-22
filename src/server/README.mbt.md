# OpenCode Server SDK for MoonBit

`totto2727/opencode-sdk/server` starts and stops a native `opencode serve` process and returns its announced HTTP base URL.

Consumer prerequisites, dependencies, imports, and the common SDK usage are documented in the root [Setup](../../README.mbt.md#setup) and [Usage](../../README.mbt.md#usage).

## Package role

- Starts `opencode serve` with hostname, port, timeout, and JSON configuration options on the native target.
- Accepts supported legacy and v2 readiness output, then exposes the validated HTTP URL through `Server::url`.
- Reports startup, timeout, malformed-output, exit, and cleanup failures as typed `ServerError` values.
- Owns process waiting and temporary log cleanup through idempotent `Server::close`.

## Runnable example

See the [managed Server health example](./examples/health/main.mbt) for the complete create, announced-URL, and close lifecycle.

## API

[Mooncakes API reference for `totto2727/opencode-sdk/server`](https://mooncakes.io/docs/totto2727/opencode-sdk/server)
