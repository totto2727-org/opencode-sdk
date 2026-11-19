///|
/// A completed text part emitted by OpenCode.
#derive(Debug, Eq)
pub struct TextEvent {
  session_id : String
  text : String
}

///|
pub extend TextEvent with Debug::{to_repr}

///|
pub extend TextEvent with Eq::{not_equal, equal}

///|
/// A completed reasoning part emitted when thinking output is enabled.
#derive(Debug, Eq)
pub struct ReasoningEvent {
  session_id : String
  text : String
}

///|
pub extend ReasoningEvent with Debug::{to_repr}

///|
pub extend ReasoningEvent with Eq::{not_equal, equal}

///|
/// The terminal or active state of an OpenCode tool call.
#derive(Debug, Eq)
pub enum ToolUseStatus {
  Completed
  Failed
}

///|
pub extend ToolUseStatus with Debug::{to_repr}

///|
pub extend ToolUseStatus with Eq::{not_equal, equal}

///|
/// A tool-use part emitted by OpenCode.
#derive(Debug, Eq)
pub struct ToolUseEvent {
  session_id : String
  call_id : String
  tool : String
  status : ToolUseStatus
}

///|
pub extend ToolUseEvent with Debug::{to_repr}

///|
pub extend ToolUseEvent with Eq::{not_equal, equal}

///|
/// A marker emitted when OpenCode begins a model step.
#derive(Debug, Eq)
pub struct StepStartEvent {
  session_id : String
}

///|
pub extend StepStartEvent with Debug::{to_repr}

///|
pub extend StepStartEvent with Eq::{not_equal, equal}

///|
/// Token usage reported when OpenCode finishes a model step.
#derive(Debug, Eq)
pub struct Usage {
  input_tokens : Int32
  output_tokens : Int32
  reasoning_tokens : Int32
  cache_read_tokens : Int32
  cache_write_tokens : Int32
}

///|
pub extend Usage with Debug::{to_repr}

///|
pub extend Usage with Eq::{not_equal, equal}

///|
/// A marker and usage payload emitted when OpenCode finishes a model step.
#derive(Debug, Eq)
pub struct StepFinishEvent {
  session_id : String
  reason : String
  cost : Double
  usage : Usage
}

///|
pub extend StepFinishEvent with Debug::{to_repr}

///|
pub extend StepFinishEvent with Eq::{not_equal, equal}

///|
/// A fatal error emitted by the OpenCode event stream.
#derive(Debug, Eq)
pub struct ThreadErrorEvent {
  session_id : String?
  message : String
}

///|
pub extend ThreadErrorEvent with Debug::{to_repr}

///|
pub extend ThreadErrorEvent with Eq::{not_equal, equal}

///|
/// One typed JSONL event emitted by `opencode run --format json`.
///
/// Text and reasoning parts carry their session identifier. Tool-use events
/// expose the call identifier, tool name, and terminal status. Step-finish
/// events retain cost and token usage, while stream errors carry the provider
/// message when OpenCode reports one.
#derive(Debug, Eq)
pub enum ThreadEvent {
  Text(TextEvent)
  Reasoning(ReasoningEvent)
  ToolUse(ToolUseEvent)
  StepStart(StepStartEvent)
  StepFinish(StepFinishEvent)
  StreamError(ThreadErrorEvent)
}

///|
pub extend ThreadEvent with Debug::{to_repr}

///|
pub extend ThreadEvent with Eq::{not_equal, equal}
