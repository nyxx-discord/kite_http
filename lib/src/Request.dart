part of kite_http;

class Request {
  late final HttpRequest _internalRequest;

  late final HttpHeaders headers;

  late final Future<String> _body;

  Request._fromHttpRequest(HttpRequest req) {
    this._internalRequest = req;

    this.headers = req.headers;
    this._body = utf8.decodeStream(this._internalRequest);
  }

  Future<String> get body => this._body;

  Future<Map<dynamic, dynamic>> get json async =>
      jsonDecode(await this.body) as Map<dynamic, dynamic>;
}
