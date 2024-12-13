import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:netword_logger/feature/model/api_tracker_model.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();

  ApiTracker? _latestResponse;

  NetworkService._internal();

  // Factory constructor for singleton instance
  factory NetworkService() {
    return _instance;
  }

  ApiTracker? get apiResponse => _latestResponse;

  /// Handles HTTP responses and returns an ApiTracker
  void trackHttpResponse({
    required http.Response response,
    required String endpoint,
    String? error,
  }) {
    final tracker = ApiTracker(
      endpoint: endpoint,
      statusCode: response.statusCode,
      response: response.body,
      errorResponse: error,
      timestamp: DateTime.now(),
    );
    _latestResponse = tracker;
  }

  Future<void> trackDioResponse({
    required Response? response,
    required String endpoint,
    String? error,
  }) async {
    final DateTime requestTime = DateTime.now();

    _latestResponse = ApiTracker(
      endpoint: endpoint,
      statusCode: response?.statusCode ?? 500, // Default to 500 for errors
      response: error == null ? response?.data.toString() : null,
      errorResponse: error,
      timestamp: requestTime,
    );
  }
}
