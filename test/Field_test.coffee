
fs = require 'fs'
chai = require 'chai'
should = chai.should()
Field = require '../lib/fields/Field'


describe 'Field', () ->
  it 'is defined', () ->
    Field.should.be.a 'function'

