part of kite_http;

/// Controles the response for a HTTP Request
class Response {
  bool _hasResponded = false;

  late final HttpRequest _req;

  Response._fromHttpRequest(HttpRequest req) {
    this._req = req;
  }

	/// Send a JSON response back
  void json(Map<dynamic, dynamic> data, {bool throwErr = false}) {
    if (this._hasResponded) {
      if (throwErr) {
        throw "Already Defined Data!";
      }
      return;
    }

    this._hasResponded = true;

    this._req.response.headers.add("Content-Type", "application/json");

    this._req.response.write(jsonEncode(data));
    this._req.response.close();
  }

	/// Send a string response back.
  void string(String data, {bool throwErr = false}) {
    if (this._hasResponded) {
      if (throwErr) {
        throw "Already Defined Data!";
      }
      return;
    }

    this._hasResponded = true;

    this._req.response.headers.add("Content-Type", "text/plain");

    this._req.response.write(data);
    this._req.response.close();
  }
}
