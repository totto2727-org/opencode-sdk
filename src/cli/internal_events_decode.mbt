///|
pub impl @json.FromJson for TextEvent with fn from_json(json, path) {
  let wire : TextWire_ = decode_event_wire_(json, path)
  { session_id: wire.session_id, text: wire.text }
}

///|
pub extend TextEvent with @json.FromJson::{from_json}

///|
pub impl @json.FromJson for ReasoningEvent with fn from_json(json, path) {
  let wire : TextWire_ = decode_event_wire_(json, path)
  { session_id: wire.session_id, text: wire.text }
}

///|
pub extend ReasoningEvent with @json.FromJson::{from_json}

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
pub extend ToolUseStatus with @json.FromJson::{from_json}

///|
pub impl ToJson for ToolUseStatus with fn to_json(self) {
  match self {
    Completed => ToJson::to_json("completed")
    Failed => ToJson::to_json("error")
  }
}

///|
pub extend ToolUseStatus with ToJson::{to_json}

///|
pub impl @json.FromJson for ToolUseEvent with fn from_json(json, path) {
  let wire : ToolUseWire_ = decode_event_wire_(json, path)
  { session_id: wire.session_id, call_id: wire.call_id, tool: wire.tool, status: wire.status }
}

///|
pub extend ToolUseEvent with @json.FromJson::{from_json}

///|
pub impl @json.FromJson for StepStartEvent with fn from_json(json, path) {
  let wire : SessionWire_ = decode_event_wire_(json, path)
  { session_id: wire.session_id }
}

///|
pub extend StepStartEvent with @json.FromJson::{from_json}

///|
pub impl @json.FromJson for Usage with fn from_json(json, path) {
  let wire : UsageWire_ = decode_event_wire_(json, path)
  {
    input_tokens: wire.input.0,
    output_tokens: wire.output.0,
    reasoning_tokens: wire.reasoning.0,
    cache_read_tokens: wire.cache_read.0,
    cache_write_tokens: wire.cache_write.0,
  }
}

///|
pub extend Usage with @json.FromJson::{from_json}

///|
pub impl ToJson for Usage with fn to_json(self) {
  let wire : UsageWire_ = {
    input: WireTokenCount_(self.input_tokens),
    output: WireTokenCount_(self.output_tokens),
    reasoning: WireTokenCount_(self.reasoning_tokens),
    cache_read: WireTokenCount_(self.cache_read_tokens),
    cache_write: WireTokenCount_(self.cache_write_tokens),
  }
  ToJson::to_json(wire)
}

///|
pub extend Usage with ToJson::{to_json}

///|
pub impl @json.FromJson for StepFinishEvent with fn from_json(json, path) {
  let wire : StepFinishWire_ = decode_event_wire_(json, path)
  { session_id: wire.session_id, reason: wire.reason, cost: wire.cost.0, usage: wire.usage }
}

///|
pub extend StepFinishEvent with @json.FromJson::{from_json}

///|
pub impl @json.FromJson for ThreadErrorEvent with fn from_json(json, path) {
  let wire : ErrorWire_ = decode_event_wire_(json, path)
  let message = try {
    let detail : ErrorMessageWire_ = @json.from_json(json, path~)
    detail.message
  } catch {
    _ => wire.name
  }
  { session_id: Some(wire.session_id), message }
}

///|
pub extend ThreadErrorEvent with @json.FromJson::{from_json}

///|
pub impl @json.FromJson for ThreadEvent with fn from_json(json, path) {
  let wire : EventTypeWire_ = decode_event_wire_(json, path)
  match wire.event_type {
    "text" => Text(@json.FromJson::from_json(json, path))
    "reasoning" => Reasoning(@json.FromJson::from_json(json, path))
    "tool_use" => ToolUse(@json.FromJson::from_json(json, path))
    "step_start" => StepStart(@json.FromJson::from_json(json, path))
    "step_finish" => StepFinish(@json.FromJson::from_json(json, path))
    "error" => StreamError(@json.FromJson::from_json(json, path))
    event_type =>
      @serde.invalid(path.add_key("type"), "unsupported thread event type: \{event_type}")
  }
}

///|
pub extend ThreadEvent with @json.FromJson::{from_json}

///|
/// Return the session identifier carried by an event, when present.
fn ThreadEvent::session_id_(self : ThreadEvent) -> String? {
  match self {
    Text(event) => Some(event.session_id)
    Reasoning(event) => Some(event.session_id)
    ToolUse(event) => Some(event.session_id)
    StepStart(event) => Some(event.session_id)
    StepFinish(event) => Some(event.session_id)
    StreamError(event) => event.session_id
  }
}
