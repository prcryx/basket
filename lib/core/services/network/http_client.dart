import 'package:http/http.dart' as http;
import 'package:mr_ambarisha_frontend_new/core/common/constants/api_constants.dart';
import 'package:mr_ambarisha_frontend_new/core/services/network/http_utils.dart';

class HttpClient {
  final String host;
  Map<String, String> header;
  late http.Client client;

  HttpClient({
    required this.host,
    required this.header,
  }) : client = http.Client();

  dynamic get(
    String path, {
    Map<String, String> overrideHeader = const {},
  }) async {
    final requestHeader = {
      ...header,
      ...overrideHeader,
      // ...getRequestIdHeader()
    };
    final response = await client.get(
      HttpUtils.getParsedUrl(host, path),
      headers: requestHeader,
    );
    return HttpUtils.getResponse(response);
  }

  dynamic post(
    String path,
    dynamic data, {
    Map<String, String> overrideHeader = const {},
  }) async {
    final requestHeader = {
      ...header,
      ...overrideHeader,
      // ...getRequestIdHeader()
    };
    final contentType = requestHeader[ApiConstants.contentType];
    dynamic encodedBody;
    if (data == null) {
      encodedBody = '';
    } else {
      encodedBody = HttpUtils.encodeRequestBody(data, contentType!);
    }

    final response = await client.post(
      HttpUtils.getParsedUrl(host, path),
      body: encodedBody,
      headers: requestHeader,
    );
    return HttpUtils.getResponse(response);
  }

  dynamic put(
    String path,
    dynamic data, {
    Map<String, String> overrideHeader = const {},
  }) async {
    final requestHeader = {
      ...header,
      ...overrideHeader,
      // ...getRequestIdHeader()
    };

    final contentType = requestHeader[ApiConstants.contentType];
    dynamic encodedBody;
    if (data == null) {
      encodedBody = '';
    } else {
      encodedBody = HttpUtils.encodeRequestBody(data, contentType!);
    }

    final response = await client.put(
      HttpUtils.getParsedUrl(host, path),
      body: encodedBody,
      headers: requestHeader,
    );
    return HttpUtils.getResponse(response);
  }
  dynamic delete(
    String path,
    dynamic data, {
    Map<String, String> overrideHeader = const {},
  }) async {
    final requestHeader = {
      ...header,
      ...overrideHeader,
      // ...getRequestIdHeader()
    };

    final contentType = requestHeader[ApiConstants.contentType];
    dynamic encodedBody;
    if (data == null) {
      encodedBody = '';
    } else {
      encodedBody = HttpUtils.encodeRequestBody(data, contentType!);
    }

    final response = await client.delete(
      HttpUtils.getParsedUrl(host, path),
      body: encodedBody,
      headers: requestHeader,
    );
    return HttpUtils.getResponse(response);
  }
}
