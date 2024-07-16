abstract class HttpAdapter {
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters});
}
