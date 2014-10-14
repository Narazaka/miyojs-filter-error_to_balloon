chai = require 'chai'
chai.should()
expect = chai.expect
sinon = require 'sinon'
Miyo = require 'miyojs'
MiyoFilters = require '../error_to_balloon.js'

describe 'error_to_balloon_initialize filter', ->
	it 'should replace make_internal_server_error()', ->
		ms = new Miyo()
		ms.default_response_headers = Charset: 'UTF-8'
		for name, filter of MiyoFilters
			ms.filters[name] = filter
		entry =
			filters: ['error_to_balloon_initialize']
			argument:
				dummy: 'dummy'
		return_argument = ms.call_filters entry, null, '_load'
		return_argument.should.be.deep.equal entry.argument
		error = new Error 'guest\nguest'
		request = sinon.stub()
		response = ms.make_internal_server_error(error, request)
		response.status_line.code.should.be.equal 200
		response.headers.get('Charset').should.be.equal 'UTF-8'
		value = response.headers.get('Value')
		value.should.match /X-Miyo-ERROR:\\n/
		value.should.match /guest\\nguest/
		value.should.match /^[^\n\r]*$/
