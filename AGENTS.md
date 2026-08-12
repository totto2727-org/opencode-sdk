# OpenCode SDK repository instructions

## Internal MoonBit implementation

- Put provider-specific private implementation details in `internal_*.mbt` files. Do not repeat `opencode` in those filenames.
- Name package-private variables, functions, methods, constants, and private helper types that belong to internal implementation with a trailing underscore, such as `event_session_id_lens_` or `session_id_`. Do not prefix identifiers with `internal_` or abbreviate the prefix to `i_`.
- Keep local variables and function parameters descriptive without forcing a trailing underscore.
- Keep files that define the shared provider interface focused on common public symbols. Move provider-specific protocol decoding and helper implementations into `internal_*.mbt` files.
- Prefer typed Lens constructors, including `custom` for types with matching `FromJson` and `ToJson` wire contracts. Do not use `Lens[Json]` by default; when a type constraint requires a raw JSON lens, document that reason next to its declaration.
- Keep public API symbols provider-neutral and do not add compatibility aliases or shims for renamed internal symbols.
- Keep `src/server/**` as a separate provider-specific package boundary; CLI internal naming changes do not alter the Server contract.
