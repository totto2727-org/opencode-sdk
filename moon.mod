name = "totto2727/opencode-sdk"

version = "0.4.1"

readme = "README.mbt.md"

repository = "https://github.com/totto2727-org/opencode-sdk"

license = "MIT"

keywords = [ "opencode", "sdk", "cli", "server", "moonbit" ]

description = "MoonBit SDKs for OpenCode CLI execution and managed Server lifecycle"

preferred_target = "wasm"

supported_targets = "+wasm+native"

import {
  "moonbitlang/x@0.5.1",
  "moonbitlang/async@0.21.0",
  "totto2727/agent-core-sdk@0.1.2",
  "totto2727/copy@0.2.0",
  "totto2727/lens@0.4.3",
}

source = "./src"
