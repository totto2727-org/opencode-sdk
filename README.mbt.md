# OpenCode SDK for MoonBit

MoonBit client for the [`opencode` CLI](https://dev.opencode.ai/docs/cli/).

- CLI: `wasm` (preferred), `native`
- Server: `native`
- Executable: `PATH` or `Options.executable_path_override`

## Quickstart

```mbt check
///|
async fn example {
  let thread = @opencode.Client::Client().start_thread()
  let turn = thread.run(@opencode.Input::Prompt("Explain this repository."))
  println(turn.final_response)
}
```

## Streaming

```mbt check
///|
async fn stream_example {
  let thread = @opencode.Client::Client().start_thread()
  thread.run_streamed(
    @opencode.Input::Prompt("Summarize the current changes."),
    async fn(event) {
      match event {
        @opencode.Text(text) => println(text.text)
        _ => ()
      }
      @async.pause()
    },
  )
}
```

## API

- [Client](src/cli/client.mbt) and [options](src/cli/options.mbt)
- [Thread and input](src/cli/thread.mbt)
- [Thread options](src/cli/thread_options.mbt)
- [Events](src/cli/events.mbt)
- [Server](src/server/server.mbt) and [health example](src/server/examples/health)

## Development

```sh
nix develop
moon check
moon test
moon build
```
