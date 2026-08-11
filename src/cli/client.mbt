///|
/// Main client for interacting with the OpenCode agent through its CLI.
pub struct Client {
  // ClientOptions is not retained because Exec captures every field at construction.
  priv exec : Exec
}

///|
/// Construct an OpenCode CLI client.
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
pub fn Client::start_thread(
  self : Client,
  options? : ThreadOptions = ThreadOptions::ThreadOptions(),
) -> Thread {
  Thread::Thread(self.exec, options)
}

///|
/// Resume a persisted OpenCode session by identifier.
pub fn Client::resume_thread(
  self : Client,
  id : String,
  options? : ThreadOptions = ThreadOptions::ThreadOptions(),
) -> Thread {
  Thread::Thread(self.exec, options, id~)
}
