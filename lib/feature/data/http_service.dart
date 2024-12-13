import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:netword_logger/feature/service/network_response.dart';
import 'package:dio/dio.dart';

class HttpService {
  static Future<http.Response> httpRequest({
    required String method,
    required String url,
    Map<String, String>? headers,
    Object? body,
  }) async {
    try {
      http.Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await http.get(Uri.parse(url), headers: headers);
          break;
        case 'POST':
          response = await http.post(Uri.parse(url),
              headers: headers, body: json.encode(body));
          break;
        case 'PUT':
          response = await http.put(Uri.parse(url),
              headers: headers, body: json.encode(body));
          break;
        case 'PATCH':
          response = await http.patch(Uri.parse(url),
              headers: headers, body: json.encode(body));
          break;
        case 'DELETE':
          response = await http.delete(Uri.parse(url), headers: headers);
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method: $method');
      }

      // Track response
      NetworkService().trackHttpResponse(
        response: response,
        endpoint: url,
      );
      return response;
    } catch (e) {
      NetworkService().trackHttpResponse(
        response: http.Response('No body', 500), // Simulated error response
        endpoint: url,
        error: e.toString(),
      );
      rethrow;
    }
  }

  static Future<Response> dioRequest({
    required String method,
    required String url,
    Map<String, dynamic>? headers,
    Object? body,
  }) async {
    final Dio dio = Dio();

    try {
      Response response;

      switch (method.toUpperCase()) {
        case 'GET':
          response = await dio.get(url, options: Options(headers: headers));
          break;
        case 'POST':
          response = await dio.post(url,
              data: json.encode(body), options: Options(headers: headers));
          break;
        case 'PUT':
          response = await dio.put(url,
              data: json.encode(body), options: Options(headers: headers));
          break;
        case 'PATCH':
          response = await dio.patch(url,
              data: json.encode(body), options: Options(headers: headers));
          break;
        case 'DELETE':
          response = await dio.delete(url, options: Options(headers: headers));
          break;
        default:
          throw UnsupportedError('Unsupported HTTP method: $method');
      }
      print("responseresponseresponse");

      // Track response
      await NetworkService().trackDioResponse(
        response: response,
        endpoint: url,
      );
      return response;
    } catch (e) {
      final DioError dioError = e as DioError;

      // Track error response
      await NetworkService().trackDioResponse(
        response: dioError.response,
        endpoint: url,
        error: dioError.message,
      );
      rethrow;
    }
  }
}
