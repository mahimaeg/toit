// Copyright (C) 2019 Toitware ApS. All rights reserved.

import .document
import ..rpc

/**
How a completion was triggered.
*/
interface CompletionTriggerKind:
  /**
  Completion was triggered by typing an identifier (24x7 code
    complete), manual invocation (e.g Ctrl+Space) or via API.
  */
  static invoked ::= 1

  /**
  Completion was triggered by a trigger character specified by
    the `triggerCharacters` properties of the `CompletionRegistrationOptions`.
  */
  static trigger_character ::= 2

  /**
  Completion was re-triggered as the current completion list is incomplete.
  */
  static trigger_for_incomplete_completions ::= 3


/**
Contains additional information about the context in which a completion request is triggered.
*/
class CompletionContext extends MapWrapper:
  constructor json_map/Map: super json_map

  /**
  How the completion was triggered.
   */
  trigger_kind -> int:  // A CompletionTriggerKind
    return at_ "trigger_kind"

  /**
  The trigger character (a single character) that has trigger code complete.
    Is undefined if `triggerKind !== CompletionTriggerKind.TriggerCharacter`
  */
  trigger_character -> string?:
    return lookup_ "triggerCharacter"

class CompletionParams extends TextDocumentPositionParams:
  constructor json_map/Map: super json_map

  /**
  The completion context. This is only available if the client specifies
    to send this using `ClientCapabilities.textDocument.completion.contextSupport === true`
  */
  context -> CompletionContext?:
    return lookup_ "context": CompletionContext it

class CompletionItem extends MapWrapper:
  /**
  Creates a completion item.
  If $kind is equal to -1, indicates that no kind was provided.
  */
  constructor
      --label /string
      --kind  /int:
    map_["label"] = label
    if kind != -1: map_["kind"] = kind
