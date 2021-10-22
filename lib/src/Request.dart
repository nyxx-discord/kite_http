part of kite_http;

/// Data from HTTP Request
class Request {
  late final HttpRequest _internalRequest;

	/// Recieved Headers
  late final HttpHeaders headers;

  late final Future<String> _body;

  Request._fromHttpRequest(HttpRequest req) {
    this._internalRequest = req;

    this.headers = req.headers;
    this._body = utf8.decodeStream(this._internalRequest);
  }

	/// Raw String body from Request
  Future<String> get body => this._body;

	/// Json body from request
  Future<Map<dynamic, dynamic>> get json async =>
      jsonDecode(await this.body) as Map<dynamic, dynamic>;
}
