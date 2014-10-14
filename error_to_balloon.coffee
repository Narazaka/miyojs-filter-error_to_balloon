### (C) 2014 Narazaka : Licensed under The MIT License - http://narazaka.net/license/MIT?2014 ###

unless MiyoFilters?
	MiyoFilters = {}

MiyoFilters.error_to_balloon_initialize = type: 'through', filter: (argument, request, id, stash) ->
	@make_internal_server_error = (error, request) ->
		response = @build_response()
		response.status_line.protocol = 'SHIORI'
		response.status_line.version = '3.0'
		response.status_line.code = 200
		for name, content of @default_response_headers
			response.headers.set name, content
		response.headers.set 'Value', '\h\s[0]X-Miyo-ERROR:\\n' + "#{error}".replace(/\r/g, '').replace(/\n/g, '\\n')
		response
	argument

if module? and module.exports?
	module.exports = MiyoFilters
