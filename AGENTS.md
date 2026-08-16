# OpenCode SDK for MoonBit

## Repository structure

```text
src/cli/     OpenCode CLI client, thread, event, and process adapter
src/server/  Native managed `opencode serve` lifecycle and health example
```

`README.mbt.md` is the canonical module overview and `README.md` is its relative symlink. The detailed CLI and server API documents live at `src/cli/README.mbt.md` and `src/server/README.mbt.md`; they are package-local canonical documents without duplicate aliases.

## Development commands

### Execution rules

- Run MoonBit commands from the repository root.
- Use `moon` directly for this standalone module; do not add a workspace overlay or local path dependency.
- Keep `src/server/**` native-only and keep the CLI package target-neutral.

### Standard tasks

- `moon check` — Check the module for the preferred target.
- `moon test` — Run module tests, including native process tests.
- `moon build` — Build the module for the preferred target.
- `moon package --list` — Verify the published package layout.
- `moon check README.mbt.md` — Validate supported MoonBit blocks in the module overview.
- `cd src/cli && moon check README.mbt.md && moon test README.mbt.md` — Validate the CLI package document and its executable examples.
- `cd src/server && moon check --target native README.mbt.md && moon test --target native README.mbt.md` — Validate the native server package document and its executable examples.

CI runs the shared Nix setup and MoonBit setup/check actions from the monorepo `main` branch. Target-unspecified validation selects the module's preferred `wasm` target; native CLI support is declared but is not part of the regular CI gate. The managed Server package remains native-only because it depends on native process and filesystem APIs.

## Architecture

### CLI package

- `src/cli` builds `opencode run --format json` invocations and decodes provider JSONL into typed `ThreadEvent` values.
- `totto2727/agent-core-sdk/cli` owns the shared child-process lifecycle, ordered JSONL delivery, stderr capture, exit status, and cancellation cleanup.
- `Thread::run` buffers completed text events into `Turn::final_response`; `Thread::run_streamed` delivers each event through an asynchronous callback.
- `src/cli/README.mbt.md` owns the detailed CLI end-user API examples and links directly to the CLI Mooncakes reference.

### Managed Server package

- `src/server` starts `opencode serve`, waits for its announced HTTP URL, and owns process/log cleanup.
- `Server` does not provide an HTTP client and does not share CLI event or thread types.
- The task group passed to `create_opencode_server` must outlive the returned `Server`; call `Server::close` inside the task-group body on success and failure.
- `src/server/README.mbt.md` owns the detailed server end-user API examples and links directly to the server Mooncakes reference.

### Targets and development shells

- The module and CLI package declare `+wasm+native` with `wasm` as the preferred target.
- The default Nix shell contains MoonBit only; the `ci` shell adds the official OpenCode package for process tests.

## Development tools

- **MoonBit**: Provides module checks, tests, builds, package generation, and Mooncakes documentation.
- **Nix**: Provides the pinned development shell and the CI shell with the OpenCode executable.
- **Mooncakes**: Publishes the module and hosts the generated API reference at [totto2727/opencode-sdk](https://mooncakes.io/docs/totto2727/opencode-sdk).

## Package-specific rules

- Put provider-specific private implementation details in `internal_*.mbt` files. Do not repeat `opencode` in those filenames.
- Name package-private variables, functions, methods, constants, and private helper types that belong to internal implementation with a trailing underscore, such as `event_session_id_lens_` or `session_id_`. Do not prefix identifiers with `internal_` or abbreviate the prefix to `i_`.
- Keep local variables and function parameters descriptive without forcing a trailing underscore.
- Keep files that define the shared provider interface focused on common public symbols. Move provider-specific protocol decoding and helper implementations into `internal_*.mbt` files.
- Prefer typed Lens constructors, including `custom` for types with matching `FromJson` and `ToJson` wire contracts. Do not use `Lens[Json]` by default; when a type constraint requires a raw JSON lens, document that reason next to its declaration.
- Keep public API symbols provider-neutral and do not add compatibility aliases or shims for renamed internal symbols.
- Keep `src/server/**` as a separate provider-specific package boundary; CLI internal naming changes do not alter the Server contract.
- Keep public API behavior and representative examples in `///` documentation so the Mooncakes API reference remains useful when README details are delegated to the registry.

_This AGENTS.md was generated from the [share-artifact skill](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/SKILL.md) and [AGENTS template](https://raw.githubusercontent.com/totto2727-org/agent/refs/heads/main/plugins/totto2727-coding/skills/share-artifact/agents/template.md)._
