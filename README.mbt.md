# OpenCode SDK for MoonBit

`totto2727/opencode-sdk` provides MoonBit SDKs for running OpenCode through its CLI and managing an OpenCode server process.

## Usage

Use the [CLI package guide](src/cli/README.mbt.md) for a consumer client and turn example plus a checked local lifecycle example, or the [server package guide](src/server/README.mbt.md) for a checked server-options example.

Create a client and start a local thread before the first OpenCode turn:

```mbt check
///|
import {
  "totto2727/opencode-sdk/cli" @opencode,
}

///|
test "a new thread starts without a session identifier" {
  let client = @opencode.Client::Client()
  debug_inspect(client.start_thread().id(), content="None")
}
```

## Key features

- Typed JSONL events and buffered or streamed turns for `opencode run --format json`.
- New and resumed OpenCode sessions with configurable model, agent, directory, files, and environment.
- Native managed `opencode serve` lifecycle with readiness URL parsing, timeout errors, and idempotent cleanup.

The CLI package prefers `wasm`, also supports `native`, and raises typed `SdkError` values for invalid events, failed turns, and nonzero exits. The managed Server package is native-only and raises typed `ServerError` values for startup, readiness, exit, timeout, and cleanup failures.

## Prerequisites

- **MoonBit**: Install the MoonBit toolchain.
- **OpenCode**: Install the `opencode` executable and make it available on `PATH` for CLI or server execution.

## Setup

1. Add the published module to the MoonBit project.

```bash
moon add totto2727/opencode-sdk@0.4.0
```

2. Import the package required by the application in `moon.pkg`.

```moonbit nocheck
///|
import {
  "totto2727/opencode-sdk/cli" @opencode,
}
```

Use `totto2727/opencode-sdk/server` for the native managed server package.

## API

- [CLI Mooncakes API reference](https://mooncakes.io/docs/totto2727/opencode-sdk/cli)
- [Server Mooncakes API reference](https://mooncakes.io/docs/totto2727/opencode-sdk/server)

## Development

For repository structure, ownership, targets, and executable development commands, see [AGENTS.md](./AGENTS.md).

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
