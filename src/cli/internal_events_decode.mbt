///|
let event_session_id_lens_ : @lens.Lens[String] = @lens.root().string(
  "sessionID",
)

///|
let event_part_text_lens_ : @lens.Lens[String] = @lens.root()
  .object("part")
  .string("text")

///|
let event_part_call_id_lens_ : @lens.Lens[String] = @lens.root()
  .object("part")
  .string("callID")

///|
let event_part_tool_lens_ : @lens.Lens[String] = @lens.root()
  .object("part")
  .string("tool")

///|
let event_part_status_lens_ : @lens.Lens[Json] = @lens.root()
  .object("part")
  .object("state")
  .json("status")

///|
let usage_input_lens_ : @lens.Lens[Int] = @lens.root().int("input")

///|
let usage_output_lens_ : @lens.Lens[Int] = @lens.root().int("output")

///|
let usage_reasoning_lens_ : @lens.Lens[Int] = @lens.root().int("reasoning")

///|
let usage_cache_read_lens_ : @lens.Lens[Int] = @lens.root()
  .object("cache")
  .int("read")

///|
let usage_cache_write_lens_ : @lens.Lens[Int] = @lens.root()
  .object("cache")
  .int("write")

///|
let event_part_reason_lens_ : @lens.Lens[String] = @lens.root()
  .object("part")
  .string("reason")

///|
let event_part_cost_lens_ : @lens.Lens[Double] = @lens.root()
  .object("part")
  .number("cost")

///|
let event_part_tokens_lens_ : @lens.Lens[Json] = @lens.root()
  .object("part")
  .json("tokens")

///|
let event_error_name_lens_ : @lens.Lens[String] = @lens.root()
  .object("error")
  .string("name")

///|
let event_error_message_lens_ : @lens.Lens[String] = @lens.root()
  .object("error")
  .object("data")
  .string("message")

///|
let thread_event_type_lens_ : @lens.Lens[String] = @lens.root().string("type")

///|
pub impl @json.FromJson for TextEvent with fn from_json(json, path) {
  {
    session_id: event_session_id_lens_.get_or_json_decode_error(json, path),
    text: event_part_text_lens_.get_or_json_decode_error(json, path),
  }
}

///|
pub impl @json.FromJson for ReasoningEvent with fn from_json(json, path) {
  {
    session_id: event_session_id_lens_.get_or_json_decode_error(json, path),
    text: event_part_text_lens_.get_or_json_decode_error(json, path),
  }
}

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
pub impl @json.FromJson for ToolUseEvent with fn from_json(json, path) {
  let status : ToolUseStatus = event_part_status_lens_.decode_from_json(
    json, path,
  )
  {
    session_id: event_session_id_lens_.get_or_json_decode_error(json, path),
    call_id: event_part_call_id_lens_.get_or_json_decode_error(json, path),
    tool: event_part_tool_lens_.get_or_json_decode_error(json, path),
    status,
  }
}

///|
pub impl @json.FromJson for StepStartEvent with fn from_json(json, path) {
  { session_id: event_session_id_lens_.get_or_json_decode_error(json, path) }
}

///|
pub impl @json.FromJson for Usage with fn from_json(json, path) {
  {
    input_tokens: usage_input_lens_.get_or_json_decode_error(json, path),
    output_tokens: usage_output_lens_.get_or_json_decode_error(json, path),
    reasoning_tokens: usage_reasoning_lens_.get_or_json_decode_error(json, path),
    cache_read_tokens: usage_cache_read_lens_.get_or_json_decode_error(
      json, path,
    ),
    cache_write_tokens: usage_cache_write_lens_.get_or_json_decode_error(
      json, path,
    ),
  }
}

///|
pub impl @json.FromJson for StepFinishEvent with fn from_json(json, path) {
  let usage : Usage = event_part_tokens_lens_.decode_from_json(json, path)
  {
    session_id: event_session_id_lens_.get_or_json_decode_error(json, path),
    reason: event_part_reason_lens_.get_or_json_decode_error(json, path),
    cost: event_part_cost_lens_.get_or_json_decode_error(json, path),
    usage,
  }
}

///|
pub impl @json.FromJson for ThreadErrorEvent with fn from_json(json, path) {
  let name = event_error_name_lens_.get_or_json_decode_error(json, path)
  let data_message = event_error_message_lens_.get(json) catch {
    @lens.LensError::LensError(_) => name
  }
  {
    session_id: Some(
      event_session_id_lens_.get_or_json_decode_error(json, path),
    ),
    message: data_message,
  }
}

///|
pub impl @json.FromJson for ThreadEvent with fn from_json(json, path) {
  let event_type = thread_event_type_lens_.get_or_json_decode_error(json, path)
  match event_type {
    "text" => Text(@json.FromJson::from_json(json, path))
    "reasoning" => Reasoning(@json.FromJson::from_json(json, path))
    "tool_use" => ToolUse(@json.FromJson::from_json(json, path))
    "step_start" => StepStart(@json.FromJson::from_json(json, path))
    "step_finish" => StepFinish(@json.FromJson::from_json(json, path))
    "error" => StreamError(@json.FromJson::from_json(json, path))
    _ =>
      raise thread_event_type_lens_.json_decode_error(
        path,
        "unsupported thread event type: \{event_type}",
      )
  }
}

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
