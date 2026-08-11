///|
/// Errors raised at OpenCode configuration, protocol, and process boundaries.
pub suberror SdkError {
  InvalidEvent(message~ : String)
  TurnFailed(message~ : String)
  ExecFailed(code~ : Int, stderr~ : String)
} derive(Debug, Eq)
