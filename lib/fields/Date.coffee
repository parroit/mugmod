Field = require './Field'
moment = require 'moment'

momentify = (value) ->
  isDate = typeof value == 'object' && value.constructor.name == 'Date'
  isNumber = typeof value == 'number'
  if isDate ||  isNumber
    v = moment(value)
    
  else
    v = value

  [
    v.valueOf(),
    v.format ('L')
  ]

class Date extends Field
  constructor: (name, defaultValue, options) ->
    super name, moment( defaultValue ), options
  
  parse: (instance, value) ->
    instance[@name] = moment( value )
  
  stringify: (instance) ->
    value = instance[@name]
    if value == undefined || value == null
      ''
    else
      value.format('L')

  get: (instance) -> instance[@name].format('YYYY-MM-DD')
    
  validate: (instance) ->
    if @options.required && this.isEmpty(instance)
      return "#{@name} is required"

    actualValue = instance[@name]
    
    if @options.min
       
      [minValue,minDescr] = momentify @options.min
      
      
      if actualValue.valueOf() < minValue
        return "#{@name} should be after #{minDescr}"

    if @options.max
       
      [maxValue,maxDescr] = momentify @options.max
      
      if actualValue.valueOf() > maxValue
        return "#{@name} should be before #{maxDescr}"

      
    
        

module.exports = Date