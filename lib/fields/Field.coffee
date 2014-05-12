
class Field
  constructor: (name, defaultValue = null, options = {}) -> 
    if typeof name == 'object'
      options = name
      defaultValue ?= options.default
      name = ''
    else
      options.default ?= defaultValue


    

    @name = name
    @defaultValue = options.default
    @options = options


  create: (instance) ->
    instance[@name] = @defaultValue

  validate: (instance) -> null

  isEmpty: (instance) ->
    !instance[@name]

  get: (instance) -> this.stringify instance


  stringify: (instance) ->
    value = instance[@name]
    if value == undefined || value == null
      ''
    else
      value.toString()



  parse: (instance, value) ->
    instance[@name] = value

module.exports = Field