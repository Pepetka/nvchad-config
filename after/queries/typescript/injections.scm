;; extends

; styled.div<{ foo: "bar" }>`<css>`
(call_expression
  function: (non_null_expression
    (instantiation_expression
      (member_expression
        object: (identifier) @_styled
        property: (property_identifier) @_prop
        (#eq? @_styled "styled"))
      type_arguments: (type_arguments)?))
  arguments: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "styled"))

; styled(Component)<{ foo: "bar" }>`<css>`
(call_expression
  function: (non_null_expression
    (instantiation_expression
      (call_expression
        function: (identifier) @_name
        arguments: (arguments(identifier)) @_prop
        (#eq? @_name "styled"))
      type_arguments: (type_arguments)?))
  arguments: (template_string) @injection.content
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.include-children)
  (#set! injection.language "styled"))

