# OpenCode Server SDK for MoonBit

`totto2727/opencode-sdk/server` starts and stops a native `opencode serve` process and returns the HTTP base URL announced during readiness.

This package document describes the managed server API; the module overview is in [root README](../../README.md).

## Usage

Start a native managed OpenCode server, use its announced HTTP base URL for client integration, and close it before the task group exits. Running this flow requires the native target and an `opencode` executable on `PATH`.

```mbt nocheck
///|
pub async fn print_server_url() -> Unit {
  @async.with_task_group() <| group => {
    let server = @opencode.create_opencode_server(group)
    println(server.url())
    server.close()
  }
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

1. Add the published module to the MoonBit project.

```bash
moon add totto2727/opencode-sdk@0.4.0
moon add moonbitlang/async@0.20.3
```

2. Import the native server package in `moon.pkg`.

```moonbit nocheck
///|
import {
  "moonbitlang/async",
  "totto2727/opencode-sdk/server" @opencode,
}
```

## API

[Server Mooncakes API reference](https://mooncakes.io/docs/totto2727/opencode-sdk/server)

## Development

For repository targets and executable package checks, see [AGENTS.md](../../AGENTS.md).

## License

[MIT](../../LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
