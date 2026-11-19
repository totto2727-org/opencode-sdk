///|
/// Errors raised at OpenCode configuration, protocol, and process boundaries.
#derive(Debug, Eq)
pub suberror SdkError {
  InvalidEvent(message~ : String)
  TurnFailed(message~ : String)
  ExecFailed(code~ : Int32, stderr~ : String)
}

///|
pub extend SdkError with Debug::{to_repr}

///|
pub extend SdkError with Eq::{not_equal, equal}
