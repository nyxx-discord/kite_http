part of kite_http;

class HandlerMetadata {
  final RegExp route;
  final String method;

  const HandlerMetadata(this.route, this.method);
}
