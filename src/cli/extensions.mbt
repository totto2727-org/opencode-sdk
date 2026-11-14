///|
pub extend ClientOptions with Eq::{not_equal, equal}

///|
pub extend SdkError with Debug::{to_repr}

///|
pub extend SdkError with Eq::{not_equal, equal}

///|
pub extend TextEvent with Debug::{to_repr}

///|
pub extend TextEvent with Eq::{not_equal, equal}

///|
pub extend ReasoningEvent with Debug::{to_repr}

///|
pub extend ReasoningEvent with Eq::{not_equal, equal}

///|
pub extend ToolUseStatus with Debug::{to_repr}

///|
pub extend ToolUseStatus with Eq::{not_equal, equal}

///|
pub extend ToolUseEvent with Debug::{to_repr}

///|
pub extend ToolUseEvent with Eq::{not_equal, equal}

///|
pub extend StepStartEvent with Debug::{to_repr}

///|
pub extend StepStartEvent with Eq::{not_equal, equal}

///|
pub extend Usage with Debug::{to_repr}

///|
pub extend Usage with Eq::{not_equal, equal}

///|
pub extend StepFinishEvent with Debug::{to_repr}

///|
pub extend StepFinishEvent with Eq::{not_equal, equal}

///|
pub extend ThreadErrorEvent with Debug::{to_repr}

///|
pub extend ThreadErrorEvent with Eq::{not_equal, equal}

///|
pub extend ThreadEvent with Debug::{to_repr}

///|
pub extend ThreadEvent with Eq::{not_equal, equal}

///|
pub extend TextEvent with @json.FromJson::{from_json}

///|
pub extend ReasoningEvent with @json.FromJson::{from_json}

///|
pub extend ToolUseStatus with @json.FromJson::{from_json}

///|
pub extend ToolUseStatus with ToJson::{to_json}

///|
pub extend ToolUseEvent with @json.FromJson::{from_json}

///|
pub extend StepStartEvent with @json.FromJson::{from_json}

///|
pub extend Usage with @json.FromJson::{from_json}

///|
pub extend Usage with ToJson::{to_json}

///|
pub extend StepFinishEvent with @json.FromJson::{from_json}

///|
pub extend ThreadErrorEvent with @json.FromJson::{from_json}

///|
pub extend ThreadEvent with @json.FromJson::{from_json}

///|
pub extend Turn with Debug::{to_repr}

///|
pub extend Turn with Eq::{not_equal, equal}

///|
pub extend UserInput with Eq::{not_equal, equal}

///|
pub extend Input with Eq::{not_equal, equal}

///|
pub extend ThreadOptions with Eq::{not_equal, equal}
