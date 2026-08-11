///|
/// A recursively typed OpenCode configuration value.
pub(all) enum ConfigValue {
  ConfigString(String)
  ConfigInt(Int)
  ConfigDouble(Double)
  ConfigBool(Bool)
  ConfigArray(Array[ConfigValue])
  ConfigObject(Map[String, ConfigValue])
} derive(Debug, Eq)

///|
/// An OpenCode configuration object serialized into `OPENCODE_CONFIG_CONTENT`.
pub type ConfigObject = Map[String, ConfigValue]

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

///|
impl ToJson for ConfigValue with fn to_json(self) -> Json {
  match self {
    ConfigString(value) => value.to_json()
    ConfigInt(value) => value.to_json()
    ConfigDouble(value) => value.to_json()
    ConfigBool(value) => value.to_json()
    ConfigArray(values) => values.to_json()
    ConfigObject(values) => values.to_json()
  }
}
