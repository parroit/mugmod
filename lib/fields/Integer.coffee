Field = require './Field'


class Integer extends Field
  constructor: (name, defaultValue, options) ->
    super name, defaultValue, options
  
  parse: (instance, value) ->
    instance[@name] = parseInt( value )
  
  get: (instance) -> instance[@name]

  validate: (instance) ->
    if @options.required && this.isEmpty(instance)
      return "#{@name} is required"

    actualValue = instance[@name]
    
    if @options.min && actualValue < @options.min
      return "#{@name} should be greater than #{@options.min}"
    

    if @options.max && actualValue > @options.max
      return "#{@name} should be lesser than #{@options.max}"

    if @options.digits
      maxValue = parseInt(Array(@options.digits+1).join '9')
      if actualValue > maxValue
        return "#{@name} should contains at most #{@options.digits} digits"
  

module.exports = Integer