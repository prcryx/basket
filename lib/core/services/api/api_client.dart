import 'package:mr_ambarisha_frontend_new/core/common/constants/api_constants.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_endpoint.dart';
import 'package:mr_ambarisha_frontend_new/core/services/network/http_client.dart';

class ApiClient extends HttpClient {
  ApiClient()
      : super(
          host: ApiEndpoints.apiHostUrl,
          header: {
            ApiConstants.contentType: ApiConstants.jsonContentType,
          },
        );

  void updateAuthorizationHeader(String accessToken) {
    header = {
      ...header,
      ApiConstants.authorization: '${ApiConstants.bearer} $accessToken',
    };
  }

  Map<String, String> getClientAuthenticationHeader() => header;
}
