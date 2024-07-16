import 'package:dio/dio.dart';
import 'package:worstmovie/core/http/http_client.dart';

class HttpDio implements HttpAdapter {
  final Dio _dio = Dio();

  HttpDio() {
    _dio.options.baseUrl = 'https://tools.texoit.com/backend-java/api';
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await _dio.get(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      throw Exception('Failed to load data');
    }
  }
}
