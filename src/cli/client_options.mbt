///|
/// An OpenCode configuration object serialized into `OPENCODE_CONFIG_CONTENT`.
///
/// Keys and values are preserved as JSON so provider-specific OpenCode
/// configuration remains available without provider-specific SDK types.
pub type ConfigObject = Map[String, Json]

///|
/// Client options captured by the OpenCode CLI executor.
///
/// `executable_path_override` selects a specific OpenCode executable. `env`
/// replaces inherited environment variables when present, while `config` is
/// encoded as JSON and sent through `OPENCODE_CONFIG_CONTENT`.
pub struct ClientOptions {
  executable_path_override : @path.Path?
  config : ConfigObject?
  env : Map[String, String]?
} derive(Eq)

///|
/// Construct client-wide OpenCode CLI options.
pub fn ClientOptions::ClientOptions(
  executable_path_override? : @path.Path,
  config? : ConfigObject,
  env? : Map[String, String],
) -> ClientOptions {
  { executable_path_override, config, env }
}
