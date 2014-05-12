
fs = require 'fs'
chai = require 'chai'
should = chai.should()
Integer = require '../lib/fields/Integer'

describe 'Integer', () ->
  f = null
  instance = null

  it 'is defined', () ->
    Integer.should.be.a 'function'

  describe 'create property value', () ->
    before () ->
      f = new Integer('prova',42, required:true)
      instance = {}
      f.create instance
    
    it 'stringify value', () ->
      val = f.stringify(instance)
      val.should.be.equal '42'

    it 'get value', () ->
      val = f.get(instance)
      val.should.be.equal 42
    
    it 'parse value', () ->
      val = f.parse(instance,'17')
      val.should.be.equal 17
      instance.prova = 42

    it 'is instantiable', () ->
      
      instance.prova.should.be.equal 42

    it 'is validable', () ->
      result = f.validate(instance)
      should.not.exist result

    it 'empty properties not valid', () ->
      instance.prova = 0
      result = f.validate instance
      result.should.be.equal 'prova is required'

    
    it 'validate min field value', () ->
      instance.prova = 422
      f.options.min = 422
      should.not.exist f.validate instance
      instance.prova = 420
      result = f.validate instance
      
      result.should.be.equal 'prova should be greater than 422'

    it 'validate max field length', () ->
      instance.prova = 422
      delete f.options.min
      f.options.max = 424
      should.not.exist f.validate instance
      instance.prova = 425
      result = f.validate instance
      
      result.should.be.equal 'prova should be lesser than 424'
    
    it 'validate digits', () ->
      
      f.options.min = undefined
      f.options.max = undefined

      f.options.digits = 3
      instance.prova = 422
      should.not.exist f.validate instance
      instance.prova = 4255
      result = f.validate instance
      
      result.should.be.equal 'prova should contains at most 3 digits'
      


