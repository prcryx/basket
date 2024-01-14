import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mr_ambarisha_frontend_new/core/common/db/local_db.dart';
import 'package:mr_ambarisha_frontend_new/core/common/enums/auth_type.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/models/user_entity.dart';
import 'package:mr_ambarisha_frontend_new/core/domain/repositories/auth_repo.dart';
import 'package:mr_ambarisha_frontend_new/core/services/notification/notification_service.dart';

class AuthController extends GetxController {
  final AuthRepository authRepo;
  AuthController({
    required this.authRepo,
  });

  // Rx vars
  RxString rxPhoneNo = ''.obs;
  Rx<User?> rxUser = User().obs;
  Rx<AuthType> authType = AuthType.signup.obs;

  void addAccessToken(String accessToken) {
    try {
      authRepo.addAccessToken(accessToken);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<bool> registerUser(String phoneNo) async {
    try {
      rxPhoneNo.value = phoneNo;
      String? otp = await authRepo.registerUser(phoneNo);
      if (otp != null) {
        NotificationService.display('OTP', otp);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<bool> loginUser(String phoneNo) async {
    try {
      rxPhoneNo.value = phoneNo;
      String? otp = await authRepo.registerUser(phoneNo);
      if (otp != null) {
        NotificationService.display('OTP', otp);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> verifyOtp(String otp) {
    if (authType.value == AuthType.signup) {
      return _verifyOtpForRegisterUser(otp);
    } else {
      return _verifyOtpForLoginUser(otp);
    }
  }

  Future<bool> _verifyOtpForRegisterUser(String otp) async {
    try {
      UserEntity? userEntity =
          await authRepo.verifyOtpForRegisterUser(rxPhoneNo.value, otp);
      if (userEntity?.token != null) {
        DatabaseBoxes.setAccessToken(userEntity!.token!);
        DatabaseBoxes.setUserId(userEntity.user!.sId!);
        rxUser.value = userEntity.user;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> _verifyOtpForLoginUser(String otp) async {
    try {
      UserEntity? userEntity =
          await authRepo.verifyOtpForLoginUser(rxPhoneNo.value, otp);
      if (userEntity?.token != null) {
        DatabaseBoxes.setAccessToken(userEntity!.token!);
        DatabaseBoxes.setUserId(userEntity.user!.sId!);
        rxUser.value = userEntity.user;
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
