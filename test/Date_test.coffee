
fs = require 'fs'
chai = require 'chai'
should = chai.should()
DateField = require '../lib/fields/Date'

describe 'DateField', () ->
  f = null
  instance = null

  it 'is defined', () ->
    DateField.should.be.a 'function'

  describe 'create property value', () ->
    before () ->
      f = new DateField('prova',new Date(2001,8,9), required:true)
      instance = {}
      f.create instance

    it 'stringify value', () ->
      val = f.stringify(instance)
      val.should.be.equal '09/09/2001'
    
    it 'parse value', () ->
      instance.prova = null
      f.parse(instance,'2001-09-09')
      instance.prova.valueOf().should.be.equal 999986400000
      

    it 'is instantiable', () ->
      
      instance.prova.valueOf().should.be.equal 999986400000

    it 'is validable', () ->
      result = f.validate(instance)
      should.not.exist result

    it 'empty properties not valid', () ->
      instance.prova = null
      result = f.validate instance
      result.should.be.equal 'prova is required'

    
    it 'validate min field value', () ->
      instance.prova = new Date(2034,4,18)
      f.options.min = new Date(2033,4,18)
      should.not.exist f.validate instance
      instance.prova = new Date(2032,4,18)
      result = f.validate instance
      
      result.should.be.equal 'prova should be after 05/18/2033'

    it 'validate max field length', () ->
      instance.prova = new Date(2032,4,18)
      delete f.options.min
      f.options.max = new Date(2033,4,18)
      should.not.exist f.validate instance
      instance.prova = new Date(2034,4,18)
      result = f.validate instance
      
      result.should.be.equal 'prova should be before 05/18/2033'
    
      


