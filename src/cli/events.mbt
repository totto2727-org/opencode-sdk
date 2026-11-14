///|
/// A completed text part emitted by OpenCode.
#derive(Debug, Eq)
pub struct TextEvent {
  session_id : String
  text : String
}

///|
/// A completed reasoning part emitted when thinking output is enabled.
#derive(Debug, Eq)
pub struct ReasoningEvent {
  session_id : String
  text : String
}

///|
/// The terminal or active state of an OpenCode tool call.
#derive(Debug, Eq)
pub enum ToolUseStatus {
  Completed
  Failed
}

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
/// A marker emitted when OpenCode begins a model step.
#derive(Debug, Eq)
pub struct StepStartEvent {
  session_id : String
}

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
/// A marker and usage payload emitted when OpenCode finishes a model step.
#derive(Debug, Eq)
pub struct StepFinishEvent {
  session_id : String
  reason : String
  cost : Double
  usage : Usage
}

///|
/// A fatal error emitted by the OpenCode event stream.
#derive(Debug, Eq)
pub struct ThreadErrorEvent {
  session_id : String?
  message : String
}

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
