///|

///|
test "ThreadEvent decode 1 - decodes completed reasoning" {
  let event : ThreadEvent = @json.from_json(
    @json.parse(
      "{\"type\":\"reasoning\",\"timestamp\":1,\"sessionID\":\"session-1\",\"part\":{\"type\":\"reasoning\",\"text\":\"Thought\"}}",
    ),
  )
  match event {
    Reasoning(reasoning) => {
      inspect(reasoning.session_id, content="session-1")
      inspect(reasoning.text, content="Thought")
    }
    _ => fail("expected reasoning event")
  }
}

///|
test "ThreadEvent decode 2 - decodes completed tool use" {
  let event : ThreadEvent = @json.from_json(
    @json.parse(
      "{\"type\":\"tool_use\",\"timestamp\":1,\"sessionID\":\"session-1\",\"part\":{\"type\":\"tool\",\"callID\":\"call-1\",\"tool\":\"bash\",\"state\":{\"status\":\"completed\"}}}",
    ),
  )
  match event {
    ToolUse(tool) => {
      inspect(tool.session_id, content="session-1")
      inspect(tool.call_id, content="call-1")
      inspect(tool.tool, content="bash")
      debug_inspect(tool.status, content="Completed")
      json_inspect(ToJson::to_json(tool.status), content="completed")
    }
    _ => fail("expected tool-use event")
  }
}

///|
test "ThreadEvent decode 3 - decodes failed tool use" {
  let event : ThreadEvent = @json.from_json(
    @json.parse(
      "{\"type\":\"tool_use\",\"timestamp\":1,\"sessionID\":\"session-1\",\"part\":{\"type\":\"tool\",\"callID\":\"call-2\",\"tool\":\"bash\",\"state\":{\"status\":\"error\"}}}",
    ),
  )
  match event {
    ToolUse(tool) => debug_inspect(tool.status, content="Failed")
    _ => fail("expected tool-use event")
  }
}

///|
test "ThreadEvent decode 4 - decodes step usage" {
  let event : ThreadEvent = @json.from_json(
    @json.parse(
      "{\"type\":\"step_finish\",\"timestamp\":1,\"sessionID\":\"session-1\",\"part\":{\"type\":\"step-finish\",\"reason\":\"stop\",\"cost\":0.5,\"tokens\":{\"total\":14,\"input\":10,\"output\":3,\"reasoning\":1,\"cache\":{\"read\":2,\"write\":1}}}}",
    ),
  )
  match event {
    StepFinish(step) => {
      inspect(step.reason, content="stop")
      inspect(step.cost, content="0.5")
      debug_inspect(
        step.usage,
        content=(
          #|{
          #|  input_tokens: 10,
          #|  output_tokens: 3,
          #|  reasoning_tokens: 1,
          #|  cache_read_tokens: 2,
          #|  cache_write_tokens: 1,
          #|}
        ),
      )
      json_inspect(ToJson::to_json(step.usage), content={
        "input": 10,
        "output": 3,
        "reasoning": 1,
        "cache": { "read": 2, "write": 1 },
      })
    }
    _ => fail("expected step-finish event")
  }
}

///|
test "ThreadEvent decode 5 - decodes stream errors" {
  let event : ThreadEvent = @json.from_json(
    @json.parse(
      "{\"type\":\"error\",\"timestamp\":1,\"sessionID\":\"session-1\",\"error\":{\"name\":\"UnknownError\",\"data\":{\"message\":\"provider failed\"}}}",
    ),
  )
  match event {
    StreamError(error) => {
      assert_eq(error.session_id, Some("session-1"))
      inspect(error.message, content="provider failed")
    }
    _ => fail("expected error event")
  }
}

///|
test "ThreadEvent decode 6 - rejects an unknown event type" {
  let message = try {
    let _ : ThreadEvent = @json.from_json(
      @json.parse(
        "{\"type\":\"future_event\",\"timestamp\":1,\"sessionID\":\"session-1\"}",
      ),
    )
    "no error"
  } catch {
    @json.JsonDecodeError((_, message)) => message
    error => "unexpected: \{@debug.to_string(error)}"
  }
  inspect(message, content="unsupported thread event type: future_event")
}

///|
test "Usage retains numeric token coercion and nested serialization" {
  let source =
    #|{"input":3.9,"output":-3.9,"reasoning":2e1,"cache":{"read":2147483647,"write":-2147483648}}
  let usage : Usage = @json.from_json(@json.parse(source))
  assert_eq(usage.to_json(), {
    "input": 3,
    "output": -3,
    "reasoning": 20,
    "cache": { "read": 2147483647, "write": -2147483648 },
  })
}

///|
test "Thread errors fall back to the required name for any unusable detail" {
  for detail in ["{}", "{\"data\":false}", "{\"data\":{\"message\":null}}", "{\"data\":{\"message\":0}}"] {
    let error = @json.parse(detail)
    if error is Object(fields) {
      fields["name"] = ToJson::to_json("ProviderError")
    }
    let event : ThreadErrorEvent = @json.from_json({
      "error": error,
      "sessionID": "session-1",
    })
    assert_eq(event.message, "ProviderError")
  }
}

///|
test "ThreadEvent retains public decode diagnostics" {
  let root = try {
    let _ : Bool = @json.from_json(Json::null())
    fail("expected a JSON decode error")
  } catch {
    @json.JsonDecodeError((path, _)) => path
    error => raise error
  }
  let path = root.add_index(2).add_key("a/b~")
  let source =
    #|[
    #|  null,
    #|  {"type":"text","sessionID":"s"},
    #|  {"type":"text","sessionID":"s","part":[]},
    #|  {"type":"text","sessionID":"s","part":{"text":false}},
    #|  {"type":"step_finish","sessionID":"s","part":{"reason":"stop","cost":"Infinity"}},
    #|  {"type":"step_finish","sessionID":"s","part":{"reason":"stop","cost":0,"tokens":{"input":0,"output":0,"reasoning":0,"cache":{"read":"0"}}}},
    #|  {"type":"tool_use","sessionID":"s","part":{"callID":"x","tool":"read","state":{"status":false}}},
    #|  {"type":"tool_use","sessionID":"s","part":{"callID":"x","tool":"read","state":{"status":"running"}}},
    #|  {"type":"future"}
    #|]
  let inputs : Array[Json] = @json.from_json(@json.parse(source))
  let errors = inputs.map(input => {
    try {
      let _ : ThreadEvent = @json.from_json(input, path~)
      fail("expected a JSON decode error")
    } catch {
      @json.JsonDecodeError((at, message)) => (at.to_string(), message)
      error => raise error
    }
  })
  debug_inspect(errors, content=(
    #|[
    #|  (
    #|    "/2/a~1b~0",
    #|    "LensError(\n  {\n    pointer: { segments: [] },\n    code: TypeMismatch(expected=Object, actual=Null),\n    message: None,\n  },\n)",
    #|  ),
    #|  (
    #|    "/2/a~1b~0/part",
    #|    "LensError(\n  {\n    pointer: { segments: [Key(\"part\")] },\n    code: MissingProperty,\n    message: None,\n  },\n)",
    #|  ),
    #|  (
    #|    "/2/a~1b~0/part",
    #|    "LensError(\n  {\n    pointer: { segments: [Key(\"part\")] },\n    code: TypeMismatch(expected=Object, actual=Array),\n    message: None,\n  },\n)",
    #|  ),
    #|  (
    #|    "/2/a~1b~0/part/text",
    #|    "LensError(\n  {\n    pointer: { segments: [] },\n    code: TypeMismatch(expected=String, actual=Boolean),\n    message: None,\n  },\n)",
    #|  ),
    #|  (
    #|    "/2/a~1b~0/part/cost",
    #|    "LensError(\n  {\n    pointer: { segments: [] },\n    code: TypeMismatch(expected=Number, actual=String),\n    message: None,\n  },\n)",
    #|  ),
    #|  (
    #|    "/2/a~1b~0/part/tokens/cache/read",
    #|    "LensError(\n  {\n    pointer: { segments: [] },\n    code: TypeMismatch(expected=Number, actual=String),\n    message: None,\n  },\n)",
    #|  ),
    #|  ("/2/a~1b~0/part/state/status", "String::from_json: expected string"),
    #|  (
    #|    "/2/a~1b~0/part/state/status",
    #|    "ToolUseStatus::from_json: unsupported status: running",
    #|  ),
    #|  ("/2/a~1b~0/type", "unsupported thread event type: future"),
    #|]
  ))
}
