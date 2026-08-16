///|
/// Main client for interacting with the OpenCode agent through its CLI.
///
/// A client captures executable, environment, and configuration options and
/// uses them for every thread it creates. The returned thread owns each
/// `opencode run --format json` subprocess while a turn is running.
pub struct Client {
  // ClientOptions is not retained because Exec captures every field at construction.
  priv exec : Exec
}

///|
/// Construct an OpenCode CLI client.
///
/// Omit `options` to resolve `opencode` from `PATH`. Pass `ClientOptions` when
/// the executable path, inherited environment, or `OPENCODE_CONFIG_CONTENT`
/// value must be controlled by the caller.
///
/// Example:
/// ```mbt nocheck
/// let client = @opencode.Client::Client()
/// let thread = client.start_thread()
/// let turn = thread.run(@opencode.Input::Prompt("Summarize this project."))
/// println(turn.final_response)
/// ```
pub fn Client::Client(
  options? : ClientOptions = ClientOptions::ClientOptions(),
) -> Client {
  {
    exec: Exec::Exec(
      options.executable_path_override,
      options.env,
      options.config,
    ),
  }
}

///|
/// Start a new persisted OpenCode session.
///
/// The session identifier becomes available through `Thread::id` after the
/// first event arrives.
pub fn Client::start_thread(
  self : Client,
  options? : ThreadOptions = ThreadOptions::ThreadOptions(),
) -> Thread {
  Thread::Thread(self.exec, options)
}

///|
/// Resume a persisted OpenCode session by identifier.
///
/// The identifier is passed to OpenCode with `--session` on every turn.
pub fn Client::resume_thread(
  self : Client,
  id : String,
  options? : ThreadOptions = ThreadOptions::ThreadOptions(),
) -> Thread {
  Thread::Thread(self.exec, options, id~)
}
