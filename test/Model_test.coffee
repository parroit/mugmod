
fs = require 'fs'
chai = require 'chai'
should = chai.should()
Model = require '../lib/fields/Model'
String = require '../lib/fields/String'
Integer = require '../lib/fields/Integer'


Person = new Model(
  name: new String('name','', required:true),
  age: new Integer('age',51)
)

describe 'Model', () ->
  it 'is defined', () ->
    Model.should.be.a 'function'

  it 'create new objects', () ->
    p = Person.newInstance(name:'me')
    
    p.age.should.be.equal(51)
    p.name.should.be.equal('me')

  it 'validate objects', () ->
    p = Person.newInstance()
    p.name = null
    results = Person.validate(p)
    results.should.be.equal('name is required')