// Generated by CoffeeScript 1.8.0

/* (C) 2014 Narazaka : Licensed under The MIT License - http://narazaka.net/license/MIT?2014 */
var MiyoFilters;

if (typeof MiyoFilters === "undefined" || MiyoFilters === null) {
  MiyoFilters = {};
}

MiyoFilters.error_to_balloon_initialize = {
  type: 'through',
  filter: function(argument, request, id, stash) {
    this.make_internal_server_error = function(error, request) {
      var content, name, response, _ref;
      response = this.build_response();
      response.status_line.protocol = 'SHIORI';
      response.status_line.version = '3.0';
      response.status_line.code = 200;
      _ref = this.default_response_headers;
      for (name in _ref) {
        content = _ref[name];
        response.headers.set(name, content);
      }
      response.headers.set('Value', '\h\s[0]X-Miyo-ERROR:\\n' + ("" + error).replace(/\r/g, '').replace(/\n/g, '\\n'));
      return response;
    };
    return argument;
  }
};

if ((typeof module !== "undefined" && module !== null) && (module.exports != null)) {
  module.exports = MiyoFilters;
}

//# sourceMappingURL=error_to_balloon.js.map
