import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/user_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_client.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_endpoint.dart';

abstract class AuthRepository {
  Future<String?> registerUser(String phoneNo);
  Future<String?> loginUser(String phoneNo);
  Future<UserEntity?> verifyOtpForRegisterUser(String phoneNo, String otp);
  Future<UserEntity?> verifyOtpForLoginUser(String phoneNo, String otp);
  void addAccessToken(String accessToken);
}

class AuthRepositoryImpl extends GetxService implements AuthRepository {
  final ApiClient apiClient;
  AuthRepositoryImpl({
    required this.apiClient,
  });
  @override
  Future<String?> registerUser(String phoneNo) async {
    final response =
        await apiClient.post(ApiEndpoints.register, {"mobileNumber": phoneNo});
    return response['user']['otp'];
  }

  @override
  Future<String?> loginUser(String phoneNo) async {
    final response =
        await apiClient.post(ApiEndpoints.login, {"mobileNumber": phoneNo});
    return response['user']['otp'];
  }

  @override
  Future<UserEntity?> verifyOtpForRegisterUser(
      String phoneNo, String otp) async {
    final response = await apiClient.post(ApiEndpoints.verifyRegisterOtp, {
      'mobileNumber': phoneNo,
      'otp': otp,
    });
    return UserEntity.fromJson(response);
  }

  @override
  Future<UserEntity?> verifyOtpForLoginUser(String phoneNo, String otp) async {
    final response = await apiClient.post(ApiEndpoints.veifyLoginOtp, {
      'mobileNumber': phoneNo,
      'otp': otp,
    });
    return UserEntity.fromJson(response);
  }

  @override
  void addAccessToken(String accessToken) {
    apiClient.updateAuthorizationHeader(accessToken);
  }
}
