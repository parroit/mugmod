
fs = require 'fs'
chai = require 'chai'
should = chai.should()
String = require '../lib/fields/String'


describe 'String', () ->
  f = null
  instance = null

  it 'is defined', () ->
    String.should.be.a 'function'


  describe 'create property value', () ->
    before () ->
      f = new String('prova','42', required:true)
      instance = {}
      f.create instance
  
    it 'stringify value', () ->
      val = f.stringify(instance)
      val.should.be.equal '42'

    it 'parse value', () ->
      val = f.parse(instance,'ciao')
      val.should.be.equal 'ciao'
      instance.prova = '42'

    it 'is instantiable', () ->
      
      instance.prova.should.be.equal '42'

    it 'is validable', () ->
      result = f.validate(instance)
      should.not.exist result

    it 'empty properties not valid', () ->
      instance.prova = ''
      result = f.validate instance
      result.should.be.equal 'prova is required'

    it 'validate field length', () ->
      instance.prova = 'ciao'
      f.options.size = 4
      should.not.exist f.validate instance
      instance.prova = 'ciaoaa'
      result = f.validate instance
      
      result.should.be.equal 'prova should be 4 characters length'

    it 'validate min field length', () ->
      instance.prova = 'ciao'
      delete f.options.size
      f.options.min = 4
      should.not.exist f.validate instance
      instance.prova = 'ci'
      result = f.validate instance
      
      result.should.be.equal 'prova should be at least 4 characters length'

    it 'validate max field length', () ->
      instance.prova = 'ciao'
      delete f.options.min
      f.options.max = 4
      should.not.exist f.validate instance
      instance.prova = 'cicici'
      result = f.validate instance
      
      result.should.be.equal 'prova should be at most 4 characters length'
      
