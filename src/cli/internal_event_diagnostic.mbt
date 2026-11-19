///|
// These names reproduce the text of the diagnostics exposed by the old public
// FromJson implementations. Only error formatting uses these types.
#derive(Debug)
priv enum JsonKind {
  Null
  Boolean
  Number
  String
  Array
  Object
}

///|
#derive(Debug)
priv enum IssueCode {
  MissingProperty
  TypeMismatch(expected~ : JsonKind, actual~ : JsonKind)
}

///|
#derive(Debug)
priv enum PointerSegment {
  Key(String)
}

///|
#derive(Debug)
priv struct Pointer {
  segments : Array[PointerSegment]
}

///|
#derive(Debug)
priv struct Issue {
  pointer : Pointer
  code : IssueCode
  message : String?
}

///|
#derive(Debug)
priv suberror LensError {
  LensError(Issue)
}

///|
fn[T : @json.FromJson] decode_event_wire_(
  json : Json,
  path : @json.JsonPath,
) -> T raise @json.JsonDecodeError {
  @json.from_json(json, path~) catch {
    @json.JsonDecodeError((at, message)) as original => {
      // Strip the caller's pointer. The remainder contains only literal SDK
      // wire keys, all of which have no JSON Pointer escapes.
      let pointer = at.to_string()
      let relative = pointer[path.to_string().length():].to_owned()
      let expected : JsonKind? = match message {
        "expected an object" => Some(Object)
        "expected a wire number" => Some(Number)
        "String::from_json: expected string" if relative != "/part/state/status" => Some(String)
        _ => None
      }
      let segments : Array[PointerSegment] = []
      let mut value = json
      for key in relative.split("/") {
        if !key.is_empty() {
          let key = key.to_owned()
          segments.push(Key(key))
          if value is Object(fields) && fields.get(key) is Some(child) {
            value = child
          }
        }
      }
      let code = match expected {
        Some(expected) => {
          let actual : JsonKind = match value {
            Null => Null
            True | False => Boolean
            Number(_, ..) => Number
            String(_) => String
            Array(_) => Array
            Object(_) => Object
          }
          TypeMismatch(expected~, actual~)
        }
        None if message.has_prefix("missing field: ") => MissingProperty
        None => raise original
      }
      // Leaf decoder issues were relative to the selected value, whereas
      // missing keys and malformed intermediate objects used the wire root.
      let segments = match expected {
        Some(String | Number) => []
        _ => segments
      }
      @serde.invalid(at, repr(LensError({ pointer: { segments, }, code, message: None })))
    }
  }
}
