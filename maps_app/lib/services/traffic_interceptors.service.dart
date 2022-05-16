import 'package:dio/dio.dart';

class TrafficInterceptorService extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiZGFudGhvbG9neSIsImEiOiJjbDFwcW5zYjIxZ3V6M2NqeDZhYnB2cWs5In0.K5BAT6MU1wwfX9FF5UvH3Q';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    /// adds the params needed for the http request
    options.queryParameters.addAll({
      'alternatives': true,
      'geometries': 'polyline6',
      'overview': 'simplified',
      'steps': false,
      'access_token': accessToken
    });

    super.onRequest(options, handler);
  }
}
