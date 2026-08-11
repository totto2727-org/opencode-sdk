///|
/// Serializes OpenCode configuration for `OPENCODE_CONFIG_CONTENT`.
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
