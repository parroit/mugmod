
fs = require 'fs'
chai = require 'chai'
should = chai.should()
Decimal = require '../lib/fields/Decimal'

describe 'Decimal', () ->
  f = null
  instance = null

  it 'is defined', () ->
    Decimal.should.be.a 'function'

  describe 'create property value', () ->
    before () ->
      f = new Decimal('prova',42.5, required:true)
      instance = {}
      f.create instance
    
    it 'stringify value', () ->
      val = f.stringify(instance)
      val.should.be.equal '42.5'
    
    it 'parse value', () ->
      val = f.parse(instance,'17.3')
      val.should.be.equal 17.3
      instance.prova = 42.5

    it 'is instantiable', () ->
      
      instance.prova.should.be.equal 42.5

    it 'is validable', () ->
      result = f.validate(instance)
      should.not.exist result

    it 'empty properties not valid', () ->
      instance.prova = 0
      result = f.validate instance
      result.should.be.equal 'prova is required'

    it 'validate integer digits', () ->
      
      f.options.min = undefined
      f.options.max = undefined

      f.options.integerDigits = 3
      instance.prova = 422.5
      should.not.exist f.validate instance
      instance.prova = 4255.5
      result = f.validate instance
      
      result.should.be.equal 'prova should contains at most 3 integer digits'
    
    it 'validate decimal digits', () ->
      
      f.options.min = undefined
      f.options.max = undefined
      
      f.options.integerDigits = 3
      f.options.decimalDigits = 2
      instance.prova = 422.51
      should.not.exist f.validate instance
      instance.prova = 425.523
      result = f.validate instance
      
      result.should.be.equal 'prova should contains at most 2 decimal digits'
      
    
    it 'validate min field value', () ->
      instance.prova = 422.1
      f.options.min = 422.1
      should.not.exist f.validate instance
      instance.prova = 420.1
      result = f.validate instance
      
      result.should.be.equal 'prova should be greater than 422.1'

    it 'validate max field length', () ->
      instance.prova = 422.1
      delete f.options.min
      f.options.max = 424.1
      should.not.exist f.validate instance
      instance.prova = 425.1
      result = f.validate instance
      
      result.should.be.equal 'prova should be lesser than 424.1'
      


