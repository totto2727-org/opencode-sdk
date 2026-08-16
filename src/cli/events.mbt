///|
/// A completed text part emitted by OpenCode.
pub struct TextEvent {
  session_id : String
  text : String
} derive(Debug, Eq)

///|
/// A completed reasoning part emitted when thinking output is enabled.
pub struct ReasoningEvent {
  session_id : String
  text : String
} derive(Debug, Eq)

///|
/// The terminal or active state of an OpenCode tool call.
pub enum ToolUseStatus {
  Completed
  Failed
} derive(Debug, Eq)

///|
/// A tool-use part emitted by OpenCode.
pub struct ToolUseEvent {
  session_id : String
  call_id : String
  tool : String
  status : ToolUseStatus
} derive(Debug, Eq)

///|
/// A marker emitted when OpenCode begins a model step.
pub struct StepStartEvent {
  session_id : String
} derive(Debug, Eq)

///|
/// Token usage reported when OpenCode finishes a model step.
pub struct Usage {
  input_tokens : Int
  output_tokens : Int
  reasoning_tokens : Int
  cache_read_tokens : Int
  cache_write_tokens : Int
} derive(Debug, Eq)

///|
/// A marker and usage payload emitted when OpenCode finishes a model step.
pub struct StepFinishEvent {
  session_id : String
  reason : String
  cost : Double
  usage : Usage
} derive(Debug, Eq)

///|
/// A fatal error emitted by the OpenCode event stream.
pub struct ThreadErrorEvent {
  session_id : String?
  message : String
} derive(Debug, Eq)

///|
/// One typed JSONL event emitted by `opencode run --format json`.
///
/// Text and reasoning parts carry their session identifier. Tool-use events
/// expose the call identifier, tool name, and terminal status. Step-finish
/// events retain cost and token usage, while stream errors carry the provider
/// message when OpenCode reports one.
pub enum ThreadEvent {
  Text(TextEvent)
  Reasoning(ReasoningEvent)
  ToolUse(ToolUseEvent)
  StepStart(StepStartEvent)
  StepFinish(StepFinishEvent)
  StreamError(ThreadErrorEvent)
} derive(Debug, Eq)
