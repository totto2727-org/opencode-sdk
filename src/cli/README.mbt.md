# OpenCode SDK CLI for MoonBit

`totto2727/opencode-sdk/cli` owns the MoonBit client for OpenCode CLI turns and typed JSONL events.

Consumer prerequisites, installation, imports, and the basic buffered turn are documented in the root [Setup](../../README.mbt.md#setup) and [Usage](../../README.mbt.md#usage).

## Package role

- Typed JSONL events represent text, reasoning, tool calls, step usage, and stream errors.
- New and resumed threads support buffered or callback-based streamed turns.
- Client and thread options configure executable, environment, OpenCode configuration, model, agent, directory, and files.
- The package prefers `wasm`, also supports `native`, and raises typed `SdkError` values for invalid events, failed turns, and nonzero exits.

## Usage

See the [checked CLI thread flows](./test/thread_test.mbt) for completed turns, continuation, resume, configuration, and streamed events.

## API

[Mooncakes API reference for `totto2727/opencode-sdk/cli`](https://mooncakes.io/docs/totto2727/opencode-sdk/cli)

_This README was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [README template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/readme/template.md)._
