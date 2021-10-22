part of kite_http;

/// Handler type that's passed for middleware
typedef MiddlewareHandler = FutureOr<void> Function(
  Request,
  Response,
  Function(),
);

/// Handler type that's passed for requests
typedef RequestHandler = FutureOr<void> Function(
  Request,
  Response,
);

/// The kite_http server
class KiteServer {
  late final String _hostname;
  late final int _port;
  late final HttpServer _internalServer;

  final List<MiddlewareHandler> _middleware = [];
  final Map<HandlerMetadata, RequestHandler> _handlers =
      <HandlerMetadata, RequestHandler>{};

	/// Create new instace of KiteServer
  KiteServer({String listen = "0.0.0.0", int port = 8080}) {
    this._hostname = listen;
    this._port = port;
  }

	/// Register middleware
  void use(MiddlewareHandler handler) {
    this._middleware.add(handler);
  }

	/// Register handler
  void handle(HandlerMetadata route, RequestHandler handler) {
    this._handlers[route] = handler;
  }

	/// Listen for incoming requests
  void listen() async {
    this._internalServer = await HttpServer.bind(this._hostname, this._port);

    await for (final req in this._internalServer) {
      final request = Request._fromHttpRequest(req);
      final response = Response._fromHttpRequest(req);

      var runNext = true;

      for (var i = 0; i < this._middleware.length; i++) {
        if (runNext) {
          runNext = false;
          this._middleware[i](request, response, () {
            runNext = true;
          });
        }
      }

      if (response._hasResponded == false) {
        try {
          final handlerMeta = this._handlers.keys.firstWhere(
                (routeMeta) =>
                    req.method == routeMeta.method &&
                    routeMeta.route.hasMatch(req.uri.path),
              );

          this._handlers[handlerMeta]!(request, response);
          // ignore: avoid_catches_without_on_clauses
        } catch (e) {
          print(e.toString());
          response.string("404: Not Found");
        }
      }
    }
  }
}
