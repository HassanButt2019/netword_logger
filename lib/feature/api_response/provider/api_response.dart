import 'package:flutter/material.dart';
import 'package:netword_logger/feature/data/http_service.dart';
import 'package:netword_logger/utils/custom_snackbar.dart';
import 'package:netword_logger/feature/model/api_tracker_model.dart';
import 'package:netword_logger/feature/service/network_response.dart';

class ApiResponseProvider extends ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  ApiTracker? _response;
  ApiTracker? get response => _response;

  Future<void> fetchApi(String url, BuildContext context) async {
    _isLoading = true;
    notifyListeners();
    try {
      // Make the API call using ApiLogger
      await HttpService.httpRequest(
        method: "get",
        url: url,
        headers: {
          'Content-type': 'application/json; charset=UTF-8',
        },
      );
      showGlobalSnackBar("Get resposne successfully ");

      // Get the response from NetworkService singleton
      _response = NetworkService().apiResponse;
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      final String error = e.toString().replaceAll("Exception: ", "");
      showGlobalSnackBar(error);
      _isLoading = false;
      notifyListeners();
      _response = NetworkService().apiResponse;
    }
  }
}
