
class Field
  constructor: (@name, @defaultValue = null, @options = {}) ->

  create: (instance) ->
    instance[@name] = @defaultValue

  validate: (instance) -> null

  isEmpty: (instance) ->
    !instance[@name]

  stringify: (instance) ->
    value = instance[@name]
    if value == undefined || value == null
      ''
    else
      value.toString()

  parse: (instance, value) ->
    instance[@name] = value

module.exports = Field