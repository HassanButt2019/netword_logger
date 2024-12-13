class ApiTracker {
  final String endpoint; // The API endpoint
  final int? statusCode; // HTTP status code (optional for requests)
  final String? response; // API response body (optional for requests)
  final String? errorResponse; // Error message if the API fails
  final DateTime timestamp; // Time of the request/response

  ApiTracker({
    required this.endpoint,
    this.statusCode,
    this.response,
    this.errorResponse,
    required this.timestamp,
  });

  // Factory constructor for creating from JSON (if needed)
  factory ApiTracker.fromJson(Map<String, dynamic> json) {
    return ApiTracker(
      endpoint: json['endpoint'],
      statusCode: json['statusCode'],
      response: json['response'],
      errorResponse: json['errorResponse'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  // Convert instance to JSON (for storage or logging)
  Map<String, dynamic> toJson() {
    return {
      'endpoint': endpoint,
      'statusCode': statusCode,
      'response': response,
      'errorResponse': errorResponse,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  @override
  String toString() {
    return '''
    API Tracker:
    Endpoint: $endpoint
    Status Code: ${statusCode ?? 'N/A'}
    Response: ${response ?? 'N/A'}
    Error: ${errorResponse ?? 'N/A'}
    Timestamp: $timestamp
    ''';
  }
}
