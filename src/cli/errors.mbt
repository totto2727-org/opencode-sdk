///|
/// Errors raised at OpenCode configuration, protocol, and process boundaries.
#derive(Debug, Eq)
pub suberror SdkError {
  InvalidEvent(message~ : String)
  TurnFailed(message~ : String)
  ExecFailed(code~ : Int32, stderr~ : String)
}
