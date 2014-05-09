###
 mugmod
 https://github.com/parroit/mugmod
 
 Copyright (c) 2014 Andrea Parodi
 Licensed under the MIT licence.
###
chai = require 'chai'
chai.should();

mugmod = require '../lib/index'

describe 'mugmod', ()->
    it 'is defined' ,()->
        mugmod.should.be.a 'object'
    