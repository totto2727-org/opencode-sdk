# OpenCode SDK CLI for MoonBit

`totto2727/opencode-sdk/cli` owns the MoonBit client for OpenCode CLI turns and typed JSONL events.

Consumer prerequisites, installation, imports, and the basic buffered turn are documented in the root [Setup](../../README.mbt.md#setup) and [Usage](../../README.mbt.md#usage).

## Package role

- Typed JSONL events represent text, reasoning, tool calls, step usage, and stream errors.
- New and resumed threads support buffered or callback-based streamed turns.
- Client and thread options configure executable, environment, OpenCode configuration, model, agent, directory, and files.
- The package prefers `wasm`, also supports `native`, and raises typed `SdkError` values for invalid events, failed turns, and nonzero exits.

## Runnable examples

See the [checked CLI thread flows](./test/thread_test.mbt) for completed turns, continuation, resume, configuration, and streamed events.

## API

[Mooncakes API reference for `totto2727/opencode-sdk/cli`](https://mooncakes.io/docs/totto2727/opencode-sdk/cli)
