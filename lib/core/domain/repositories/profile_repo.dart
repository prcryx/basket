import 'package:mr_ambarisha_frontend_new/core/common/constants/api_constants.dart';
import 'package:mr_ambarisha_frontend_new/core/common/db/local_db.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/user_profile_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_client.dart';
import 'package:mr_ambarisha_frontend_new/core/services/api/api_endpoint.dart';

abstract class ProfileRepository {
  Future<UserProfile?> getProfile();
}

class ProfileRepositoryImpl extends ProfileRepository {
  final ApiClient apiClient;
  ProfileRepositoryImpl({
    required this.apiClient,
  });
  @override
  Future<UserProfile?> getProfile() async {
    String? accessToken = DatabaseBoxes.getAccessToken();
    final response = await apiClient.get(ApiEndpoints.me,
        overrideHeader: {ApiConstants.authorization: accessToken ?? ''});
    return UserProfile.fromJson(response['data']);
  }
}
