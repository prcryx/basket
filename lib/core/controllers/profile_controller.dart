import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/user_profile_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/profile_repo.dart';

class ProfileController extends GetxController {
  ProfileRepository repo;
  ProfileController({required this.repo});

  Rx<UserProfile?> userProfile = UserProfile(sId: null).obs;
  Future<void> getProfile() async {
    userProfile.value = await repo.getProfile();
  }
}
