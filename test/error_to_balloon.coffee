chai = require 'chai'
chai.should()
expect = chai.expect
sinon = require 'sinon'
ShioriJK = require 'shiorijk'
MiyoFilters = require '../error_to_balloon.js'

describe 'error_to_balloon_initialize filter', ->
	it 'should replace make_internal_server_error()', ->
		ms = sinon.stub()
		ms.build_response = sinon.stub()
		ms.build_response.returns new ShioriJK.Message.Response()
		ms.default_response_headers = Charset: 'UTF-8'
		argument = dummy: 'dummy'
		request = sinon.stub()
		return_argument = MiyoFilters.error_to_balloon_initialize.call ms, argument, request, 'OnTest', null
		return_argument.should.be.deep.equal argument
		error = new Error 'guest\nguest'
		response = ms.make_internal_server_error(error, request)
		response.status_line.code.should.be.equal 200
		response.headers.get('Charset').should.be.equal 'UTF-8'
		value = response.headers.get('Value')
		value.should.match /X-Miyo-ERROR:\\n/
		value.should.match /guest\\nguest/
		value.should.match /^[^\n\r]*$/
