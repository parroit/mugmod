Field = require './Field'

class String extends Field
  constructor: (name, defaultValue, options) ->
    super name, defaultValue, options
  
  validate: (instance) ->
    if @options.required && this.isEmpty(instance)
      return "#{@name} is required"

    value = instance[@name]
    if !value
      value = ''

    actualSize = value.length
      
    if @options.size && actualSize != @options.size
      return "#{@name} should be #{@options.size} characters length"

    if @options.min && actualSize < @options.min
      return "#{@name} should be at least #{@options.min} characters length"

    if @options.max && actualSize > @options.max
      return "#{@name} should be at most #{@options.max} characters length"

module.exports = String