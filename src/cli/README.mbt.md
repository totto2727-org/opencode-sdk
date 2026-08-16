# OpenCode SDK for MoonBit

`totto2727/opencode-sdk/cli` provides a MoonBit client for running OpenCode CLI turns and receiving typed JSONL events.

This package document describes the CLI API; the module overview is in [root README](../../README.md).

## Usage

Run a new OpenCode turn through the CLI package:

```mbt check
///|
async fn _example() -> Unit {
  let client = Client::Client()
  let thread = client.start_thread()
  let turn = thread.run(
    Input::Prompt("Explain this repository in one paragraph."),
  )
  println(turn.final_response)
}
```

The package-local checked version of the example keeps the same behavior without the external import alias:

```mbt check
///|
async fn _checked_example() -> Unit {
  let client = Client::Client()
  let thread = client.start_thread()
  let turn = thread.run(
    Input::Prompt("Explain this repository in one paragraph."),
  )
  println(turn.final_response)
}
```

Starting a thread is local and does not launch OpenCode until a turn runs:

```mbt check
///|
test {
  let client = Client::Client()
  debug_inspect(client.start_thread().id(), content="None")
}
```

## Key features

- Typed JSONL events for text, reasoning, tool calls, step usage, and stream errors.
- New and resumed threads with buffered or callback-based streamed turns.
- Explicit executable, environment, configuration, model, agent, directory, and file options.
- A separate native package for starting and stopping `opencode serve`.

## Prerequisites

- **MoonBit**: Install the MoonBit toolchain.
- **OpenCode**: Install the `opencode` executable and make it available on `PATH` for CLI or server execution.

## Setup

1. Add the module dependency to `moon.mod`.

```moonbit nocheck
///|
import {
  "totto2727/opencode-sdk@0.4.0",
}
```

2. Import the package needed by the application in `moon.pkg`.

```moonbit nocheck
///|
import {
  "totto2727/opencode-sdk/cli" @opencode,
}
```

## API

[CLI Mooncakes API reference](https://mooncakes.io/docs/totto2727/opencode-sdk/cli)

## Development

For repository structure, target policy, development commands, and CI details, see [AGENTS.md](../../AGENTS.md).

## License

[MIT](../../LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
