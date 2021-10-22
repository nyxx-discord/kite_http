part of kite_http;

class Response {
  bool _hasResponded = false;

  late final HttpRequest _req;

  Response._fromHttpRequest(HttpRequest req) {
    this._req = req;
  }

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
