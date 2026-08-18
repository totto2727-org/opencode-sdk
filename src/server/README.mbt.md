# OpenCode Server SDK for MoonBit

`totto2727/opencode-sdk/server` starts and stops a native `opencode serve` process and returns the HTTP base URL announced during readiness.

This package document describes the managed server API; the module overview is in [root README](../../README.md).

## Usage

Construct server options without starting a process. The server lifecycle example in the API documentation shows how to run `create_opencode_server` inside a task group and close it before the group exits.

```mbt check
///|
test "server options have stable defaults" {
  debug_inspect(
    ServerOptions::ServerOptions(),
    content=(
      #|{
      #|  hostname: "127.0.0.1",
      #|  port: 0,
      #|  timeout_ms: 5000,
      #|  config: Object({}),
      #|}
    ),
  )
}
```

## Key features

- Starts `opencode serve` with hostname, port, timeout, and JSON configuration options.
- Waits for the readiness URL and reports startup, timeout, malformed-output, exit, and cleanup failures as typed `ServerError` values.
- Owns process waiting and temporary log cleanup through `Server::close`, which is safe to call more than once.

## Prerequisites

- **MoonBit**: Install the MoonBit toolchain with native target support.
- **OpenCode**: Install the `opencode` executable and make it available on `PATH`.

## Setup

1. Add the module dependency to `moon.mod`.

```moonbit nocheck
///|
import {
  "totto2727/opencode-sdk@0.4.0",
}
```

2. Import the native server package in `moon.pkg`.

```moonbit nocheck
///|
import {
  "totto2727/opencode-sdk/server",
}
```

## API

[Server Mooncakes API reference](https://mooncakes.io/docs/totto2727/opencode-sdk/server)

## Development

For repository targets and executable package checks, see [AGENTS.md](../../AGENTS.md).

## License

[MIT](../../LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
