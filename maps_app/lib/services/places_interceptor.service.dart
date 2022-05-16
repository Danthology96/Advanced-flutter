import 'package:dio/dio.dart';

class PlacesInterceptorService extends Interceptor {
  final accessToken =
      'pk.eyJ1IjoiZGFudGhvbG9neSIsImEiOiJjbDFwcW5zYjIxZ3V6M2NqeDZhYnB2cWs5In0.K5BAT6MU1wwfX9FF5UvH3Q';
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.queryParameters
        .addAll({'access_token': accessToken, 'language': 'es', 'limit': 7});

    super.onRequest(options, handler);
  }
}
