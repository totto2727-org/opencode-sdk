///|
/// An OpenCode configuration object serialized into `OPENCODE_CONFIG_CONTENT`.
pub type ConfigObject = Map[String, Json]

///|
/// Client options captured by the OpenCode CLI executor.
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
