# OpenCode SDK for MoonBit

`totto2727/opencode-sdk` provides MoonBit clients for running the OpenCode CLI and managing an OpenCode server process.

This document is canonical `README.mbt.md`; maintain `README.md` as the relative symlink `README.md -> README.mbt.md`.

## Usage

Run a new OpenCode turn through the CLI package:

```mbt check
///|
async fn example {
  let client = @opencode.Client::Client()
  let thread = client.start_thread()
  let turn = thread.run(
    @opencode.Input::Prompt("Explain this repository in one paragraph."),
  )
  println(turn.final_response)
}
```

Import the package from Mooncakes with an alias:

```mbt
import {
  "totto2727/opencode-sdk/cli" @opencode,
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

```moonbit
import {
  "totto2727/opencode-sdk@0.4.0",
}
```

2. Import the package needed by the application in `moon.pkg`.

```moonbit
import {
  "totto2727/opencode-sdk/cli" @opencode,
}
```

## API

[Mooncakes API reference](https://mooncakes.io/docs/totto2727/opencode-sdk)

## Development

For repository structure, target policy, development commands, and CI details, see [AGENTS.md](./AGENTS.md).

## License

[MIT](./LICENSE)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
