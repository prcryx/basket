import 'dart:convert';
import 'dart:io';

import 'package:get/get_connect/http/src/exceptions/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:mr_ambarisha_frontend_new/core/common/constants/api_constants.dart';

class HttpUtils {
  static Uri getParsedUrl(String host, String path) {
    return Uri.parse('$host$path');
  }

  static dynamic encodeRequestBody(dynamic data, String contentType) {
    return contentType == ApiConstants.jsonContentType
        ? utf8.encode(json.encode(data))
        : data;
  }

  static dynamic getResponse(http.Response response) {
    switch (response.statusCode) {
      case HttpStatus.ok:
      case HttpStatus.accepted:
      case HttpStatus.noContent:
      case HttpStatus.created:
        return _getSuccessResponse(response);

      case HttpStatus.unauthorized:
        throw UnauthorizedException();

      case HttpStatus.internalServerError:
      case HttpStatus.serviceUnavailable:
      case HttpStatus.badGateway:
      case HttpStatus.badRequest:
      case HttpStatus.forbidden:
      case HttpStatus.notFound:
      default:
        throw HttpException(
          "Network Error Occurred",
        );
    }
  }

  static dynamic _getSuccessResponse(http.Response response) {
    Map<String, dynamic> responseJson = <String, dynamic>{};
    if (response.body.isNotEmpty == true) {
      final jsonResponseBody = json.decode(response.body);
      if (jsonResponseBody is Map<String, dynamic>) {
        responseJson.addAll(json.decode(response.body));
      } else {
        return jsonResponseBody;
      }
    }
    return responseJson;
  }
}
