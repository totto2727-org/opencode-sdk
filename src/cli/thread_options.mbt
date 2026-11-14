///|
/// Options applied to every turn in one OpenCode session.
///
/// `model`, `agent`, `working_directory`, `variant`, and `title` map to the
/// corresponding OpenCode CLI options. When `thinking` is true, the executor
/// adds `--thinking` so reasoning events are delivered when OpenCode emits
/// them.
#derive(Eq)
pub struct ThreadOptions {
  model : String?
  agent : String?
  working_directory : @path.Path?
  variant : String?
  title : String?
  thinking : Bool
}

///|
/// Construct optional OpenCode session settings.
pub fn ThreadOptions::ThreadOptions(
  model? : String,
  agent? : String,
  working_directory? : @path.Path,
  variant? : String,
  title? : String,
  thinking~ : Bool = false,
) -> ThreadOptions {
  { model, agent, working_directory, variant, title, thinking, }
}
