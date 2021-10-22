part of kite_http;

/// Metadata on handlers
class HandlerMetadata {
	/// The route to check for
  final RegExp route;

	/// The HTTP Verb to listen for
  final String method;

	/// Create new metadata for handler registration
  const HandlerMetadata(this.route, this.method);
}
