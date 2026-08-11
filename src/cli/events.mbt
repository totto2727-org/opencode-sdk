///|
let internal_opencode_event_session_id_lens : @lens.Lens[Json] = @lens.root().json(
  "sessionID",
)

///|
let internal_opencode_event_part_text_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("text")

///|
let internal_opencode_event_part_call_id_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("callID")

///|
let internal_opencode_event_part_tool_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("tool")

///|
let internal_opencode_event_part_status_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .object("state")
  .json("status")

///|
let internal_opencode_usage_input_lens : @lens.Lens[Json] = @lens.root().json(
  "input",
)

///|
let internal_opencode_usage_output_lens : @lens.Lens[Json] = @lens.root().json(
  "output",
)

///|
let internal_opencode_usage_reasoning_lens : @lens.Lens[Json] = @lens.root().json(
  "reasoning",
)

///|
let internal_opencode_usage_cache_read_lens : @lens.Lens[Json] = @lens.root()
  .object("cache")
  .json("read")

///|
let internal_opencode_usage_cache_write_lens : @lens.Lens[Json] = @lens.root()
  .object("cache")
  .json("write")

///|
let internal_opencode_event_part_reason_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("reason")

///|
let internal_opencode_event_part_cost_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("cost")

///|
let internal_opencode_event_part_tokens_lens : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("tokens")

///|
let internal_opencode_event_error_name_lens : @lens.Lens[Json] = @lens.root()
  .object("error")
  .json("name")

///|
let internal_opencode_event_error_message_lens : @lens.Lens[Json] = @lens.root()
  .object("error")
  .object("data")
  .json("message")

///|
let internal_opencode_thread_event_type_lens : @lens.Lens[Json] = @lens.root().json(
  "type",
)

///|
/// A completed text part emitted by OpenCode.
pub struct TextEvent {
  session_id : String
  text : String
} derive(Debug, Eq)

///|
pub impl @json.FromJson for TextEvent with fn from_json(json, path) {
  let session_id_path = internal_opencode_event_session_id_lens.add_to_json_path(
    path,
  )
  let text_path = internal_opencode_event_part_text_lens.add_to_json_path(path)
  let session_id_value = internal_opencode_event_session_id_lens.get_or_json_decode_error(
    json, path,
  )
  let text_value = internal_opencode_event_part_text_lens.get_or_json_decode_error(
    json, path,
  )
  {
    session_id: @json.FromJson::from_json(session_id_value, session_id_path),
    text: @json.FromJson::from_json(text_value, text_path),
  }
}

///|
/// A completed reasoning part emitted when thinking output is enabled.
pub struct ReasoningEvent {
  session_id : String
  text : String
} derive(Debug, Eq)

///|
pub impl @json.FromJson for ReasoningEvent with fn from_json(json, path) {
  let session_id_path = internal_opencode_event_session_id_lens.add_to_json_path(
    path,
  )
  let text_path = internal_opencode_event_part_text_lens.add_to_json_path(path)
  let session_id_value = internal_opencode_event_session_id_lens.get_or_json_decode_error(
    json, path,
  )
  let text_value = internal_opencode_event_part_text_lens.get_or_json_decode_error(
    json, path,
  )
  {
    session_id: @json.FromJson::from_json(session_id_value, session_id_path),
    text: @json.FromJson::from_json(text_value, text_path),
  }
}

///|
/// The terminal or active state of an OpenCode tool call.
pub enum ToolUseStatus {
  Completed
  Failed
} derive(Debug, Eq)

///|
pub impl @json.FromJson for ToolUseStatus with fn from_json(json, path) {
  match @json.FromJson::from_json(json, path) {
    "completed" => Completed
    "error" => Failed
    status =>
      raise @json.JsonDecodeError(
        (path, "ToolUseStatus::from_json: unsupported status: \{status}"),
      )
  }
}

///|
/// A tool-use part emitted by OpenCode.
pub struct ToolUseEvent {
  session_id : String
  call_id : String
  tool : String
  status : ToolUseStatus
} derive(Debug, Eq)

///|
pub impl @json.FromJson for ToolUseEvent with fn from_json(json, path) {
  let session_id_path = internal_opencode_event_session_id_lens.add_to_json_path(
    path,
  )
  let call_id_path = internal_opencode_event_part_call_id_lens.add_to_json_path(
    path,
  )
  let tool_path = internal_opencode_event_part_tool_lens.add_to_json_path(path)
  let status_path = internal_opencode_event_part_status_lens.add_to_json_path(
    path,
  )
  let session_id_value = internal_opencode_event_session_id_lens.get_or_json_decode_error(
    json, path,
  )
  let call_id_value = internal_opencode_event_part_call_id_lens.get_or_json_decode_error(
    json, path,
  )
  let tool_value = internal_opencode_event_part_tool_lens.get_or_json_decode_error(
    json, path,
  )
  let status_value = internal_opencode_event_part_status_lens.get_or_json_decode_error(
    json, path,
  )
  {
    session_id: @json.FromJson::from_json(session_id_value, session_id_path),
    call_id: @json.FromJson::from_json(call_id_value, call_id_path),
    tool: @json.FromJson::from_json(tool_value, tool_path),
    status: @json.FromJson::from_json(status_value, status_path),
  }
}

///|
/// A marker emitted when OpenCode begins a model step.
pub struct StepStartEvent {
  session_id : String
} derive(Debug, Eq)

///|
pub impl @json.FromJson for StepStartEvent with fn from_json(json, path) {
  let session_id_path = internal_opencode_event_session_id_lens.add_to_json_path(
    path,
  )
  let session_id_value = internal_opencode_event_session_id_lens.get_or_json_decode_error(
    json, path,
  )
  { session_id: @json.FromJson::from_json(session_id_value, session_id_path) }
}

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
pub impl @json.FromJson for Usage with fn from_json(json, path) {
  let input_path = internal_opencode_usage_input_lens.add_to_json_path(path)
  let output_path = internal_opencode_usage_output_lens.add_to_json_path(path)
  let reasoning_path = internal_opencode_usage_reasoning_lens.add_to_json_path(
    path,
  )
  let cache_read_path = internal_opencode_usage_cache_read_lens.add_to_json_path(
    path,
  )
  let cache_write_path = internal_opencode_usage_cache_write_lens.add_to_json_path(
    path,
  )
  let input_value = internal_opencode_usage_input_lens.get_or_json_decode_error(
    json, path,
  )
  let output_value = internal_opencode_usage_output_lens.get_or_json_decode_error(
    json, path,
  )
  let reasoning_value = internal_opencode_usage_reasoning_lens.get_or_json_decode_error(
    json, path,
  )
  let cache_read_value = internal_opencode_usage_cache_read_lens.get_or_json_decode_error(
    json, path,
  )
  let cache_write_value = internal_opencode_usage_cache_write_lens.get_or_json_decode_error(
    json, path,
  )
  {
    input_tokens: @json.FromJson::from_json(input_value, input_path),
    output_tokens: @json.FromJson::from_json(output_value, output_path),
    reasoning_tokens: @json.FromJson::from_json(reasoning_value, reasoning_path),
    cache_read_tokens: @json.FromJson::from_json(
      cache_read_value, cache_read_path,
    ),
    cache_write_tokens: @json.FromJson::from_json(
      cache_write_value, cache_write_path,
    ),
  }
}

///|
/// A marker and usage payload emitted when OpenCode finishes a model step.
pub struct StepFinishEvent {
  session_id : String
  reason : String
  cost : Double
  usage : Usage
} derive(Debug, Eq)

///|
pub impl @json.FromJson for StepFinishEvent with fn from_json(json, path) {
  let session_id_path = internal_opencode_event_session_id_lens.add_to_json_path(
    path,
  )
  let reason_path = internal_opencode_event_part_reason_lens.add_to_json_path(
    path,
  )
  let cost_path = internal_opencode_event_part_cost_lens.add_to_json_path(path)
  let usage_path = internal_opencode_event_part_tokens_lens.add_to_json_path(
    path,
  )
  let session_id_value = internal_opencode_event_session_id_lens.get_or_json_decode_error(
    json, path,
  )
  let reason_value = internal_opencode_event_part_reason_lens.get_or_json_decode_error(
    json, path,
  )
  let cost_value = internal_opencode_event_part_cost_lens.get_or_json_decode_error(
    json, path,
  )
  let usage_value = internal_opencode_event_part_tokens_lens.get_or_json_decode_error(
    json, path,
  )
  {
    session_id: @json.FromJson::from_json(session_id_value, session_id_path),
    reason: @json.FromJson::from_json(reason_value, reason_path),
    cost: @json.FromJson::from_json(cost_value, cost_path),
    usage: @json.FromJson::from_json(usage_value, usage_path),
  }
}

///|
/// A fatal error emitted by the OpenCode event stream.
pub struct ThreadErrorEvent {
  session_id : String?
  message : String
} derive(Debug, Eq)

///|
pub impl @json.FromJson for ThreadErrorEvent with fn from_json(json, path) {
  let name_path = internal_opencode_event_error_name_lens.add_to_json_path(path)
  let session_id_path = internal_opencode_event_session_id_lens.add_to_json_path(
    path,
  )
  let name = internal_opencode_event_error_name_lens.get_or_json_decode_error(
    json, path,
  )
  let data_message = internal_opencode_event_error_message_lens.get(json) catch {
    @lens.LensError::LensError(_) => name
  }
  let session_id_value = internal_opencode_event_session_id_lens.get_or_json_decode_error(
    json, path,
  )
  {
    session_id: Some(
      @json.FromJson::from_json(session_id_value, session_id_path),
    ),
    message: match data_message {
      String(message) => message
      _ => @json.FromJson::from_json(name, name_path)
    },
  }
}

///|
/// One typed JSONL event emitted by `opencode run --format json`.
pub enum ThreadEvent {
  Text(TextEvent)
  Reasoning(ReasoningEvent)
  ToolUse(ToolUseEvent)
  StepStart(StepStartEvent)
  StepFinish(StepFinishEvent)
  StreamError(ThreadErrorEvent)
} derive(Debug, Eq)

///|
pub impl @json.FromJson for ThreadEvent with fn from_json(json, path) {
  let type_path = internal_opencode_thread_event_type_lens.add_to_json_path(
    path,
  )
  let type_value = internal_opencode_thread_event_type_lens.get_or_json_decode_error(
    json, path,
  )
  let event_type : String = @json.FromJson::from_json(type_value, type_path)
  match event_type {
    "text" => Text(@json.FromJson::from_json(json, path))
    "reasoning" => Reasoning(@json.FromJson::from_json(json, path))
    "tool_use" => ToolUse(@json.FromJson::from_json(json, path))
    "step_start" => StepStart(@json.FromJson::from_json(json, path))
    "step_finish" => StepFinish(@json.FromJson::from_json(json, path))
    "error" => StreamError(@json.FromJson::from_json(json, path))
    _ =>
      raise internal_opencode_thread_event_type_lens.json_decode_error(
        path,
        "unsupported thread event type: \{event_type}",
      )
  }
}

///|
/// Return the session identifier carried by an event, when present.
fn ThreadEvent::internal_opencode_session_id(self : ThreadEvent) -> String? {
  match self {
    Text(event) => Some(event.session_id)
    Reasoning(event) => Some(event.session_id)
    ToolUse(event) => Some(event.session_id)
    StepStart(event) => Some(event.session_id)
    StepFinish(event) => Some(event.session_id)
    StreamError(event) => event.session_id
  }
}
