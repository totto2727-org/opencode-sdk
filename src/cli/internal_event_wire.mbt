///|
#custom.serde(decode_only)
priv struct TextWire_ {
  #custom.serde(rename="sessionID")
  session_id : String
  #custom.serde(path=["part", "text"])
  text : String
}

///|
#custom.serde(decode_only)
priv struct ToolUseWire_ {
  #custom.serde(rename="sessionID")
  session_id : String
  #custom.serde(path=["part", "callID"])
  call_id : String
  #custom.serde(path=["part", "tool"])
  tool : String
  #custom.serde(path=["part", "state", "status"])
  status : ToolUseStatus
}

///|
#custom.serde(decode_only)
priv struct SessionWire_ {
  #custom.serde(rename="sessionID")
  session_id : String
}

///|
#custom.serde
priv struct UsageWire_ {
  input : WireTokenCount_
  output : WireTokenCount_
  reasoning : WireTokenCount_
  #custom.serde(path=["cache", "read"])
  cache_read : WireTokenCount_
  #custom.serde(path=["cache", "write"])
  cache_write : WireTokenCount_
}

///|
#custom.serde(decode_only)
priv struct StepFinishWire_ {
  #custom.serde(rename="sessionID")
  session_id : String
  #custom.serde(path=["part", "reason"])
  reason : String
  #custom.serde(path=["part", "cost"])
  cost : WireNumber_
  #custom.serde(path=["part", "tokens"])
  usage : Usage
}

///|
#custom.serde(decode_only)
priv struct ErrorWire_ {
  #custom.serde(path=["error", "name"])
  name : String
  #custom.serde(rename="sessionID")
  session_id : String
}

///|
#custom.serde(decode_only)
priv struct ErrorMessageWire_ {
  #custom.serde(path=["error", "data", "message"])
  message : String
}

///|
#custom.serde(decode_only)
priv struct EventTypeWire_ {
  #custom.serde(rename="type")
  event_type : String
}

///|
priv struct WireNumber_(Double)

///|
impl @json.FromJson for WireNumber_ with fn from_json(json, path) {
  match json {
    Number(n, ..) => WireNumber_(n)
    _ => @serde.invalid(path, "expected a wire number")
  }
}

///|
priv struct WireTokenCount_(Int32)

///|
impl @json.FromJson for WireTokenCount_ with fn from_json(json, path) {
  let WireNumber_(number) = @json.from_json(json, path~)
  WireTokenCount_(number.to_int())
}

///|
impl ToJson for WireTokenCount_ with fn to_json(self) {
  ToJson::to_json(self.0)
}
