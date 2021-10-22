import 'package:kite_http/kite_http.dart';

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
