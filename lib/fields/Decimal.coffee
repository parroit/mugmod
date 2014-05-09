Field = require './Field'
lang = require '../lang'

class Decimal extends Field
  constructor: (name, defaultValue, options) ->
    super name, defaultValue, options
  
  parse: (instance, value) ->
    instance[@name] = parseFloat( value )

  validate: (instance) ->
    if @options.required && this.isEmpty(instance)
      return lang.current.FIELD_REQUIRED @name

    actualValue = instance[@name]
    
    if @options.min && actualValue < @options.min
      return "#{@name} should be greater than #{@options.min}"

    if @options.max && actualValue > @options.max
      return "#{@name} should be lesser than #{@options.max}"
    

    if @options.integerDigits
      maxValue = parseInt(Array(@options.integerDigits+1).join '9')
      if parseInt(actualValue) > maxValue
        return lang.current.TOO_INTEGER_DIGITS @name, @options.integerDigits

    if @options.decimalDigits
      maxDecimal = parseInt(Array(@options.decimalDigits+1).join '9')
      actualDecimal = actualValue.toString()
      if actualDecimal.indexOf(".") > -1
        actualDecimal = parseInt(actualDecimal.split(".")[1])

      if actualDecimal > maxDecimal
        return lang.current.TOO_DECIMAL_DIGITS @name, @options.decimalDigits
           

module.exports = Decimal