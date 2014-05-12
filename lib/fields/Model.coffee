defineProperty = (instance, data, name, type) ->
  field = '_' + name
  Object.defineProperty instance,name,
    get: () -> this[field]
    set: (value) -> this[field] = value

  if data[name]
    instance[name] = data[name]
  else
    type.create(instance)

class Model
  constructor: (@definition) ->

  newInstance: (data = {}) ->
    if ! @initialized
      for own name,type of @definition  
        type.name = name 
      @initialized = true

    instance = {}
    for own name,type of @definition
      defineProperty instance, data, name, type
      
    instance

  validate: (instance) ->
    for own name,type of @definition
      result = type.validate(instance)
      if result
        return result
    null

module.exports = Model