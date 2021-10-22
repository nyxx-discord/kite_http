# kite_http

[![pub](https://img.shields.io/pub/v/kite_http.svg)](https://pub.dartlang.org/packages/kite_http)
[![documentation](https://img.shields.io/badge/Documentation-kite.http-green.svg)](https://pub.dev/documentation/kite_http/latest/)

<hr/>

# Features

- **Middleware** <br>
  Support for custom middleware
- **RegExp Routing** <br>
  Uses Regex for routing

# Example

```dart
void main() {
  final server = KiteServer();

  server.use(middleware);

  server.handle(
    HandlerMetadata(
      RegExp(
        r"(\/)?",
        multiLine: true,
        caseSensitive: false,
      ),
      "GET",
    ),
    handler,
  );

  server.listen();
}

void middleware(Request req, Response res, Function() next) async {
  next();
}

void handler(Request req, Response res) async {
  final body = await req.json;

  return res.json(body);
}

```