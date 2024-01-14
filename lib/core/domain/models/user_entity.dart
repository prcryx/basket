class UserEntity {
  String? token;
  User? user;

  UserEntity({this.token, this.user});

  UserEntity.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? sId;
  String? mobileNumber;
  int? iV;
  String? createdAt;
  bool? isVerified;
  String? otp;
  String? profileImage;
  String? role;
  int? wallet;

  User(
      {this.sId,
      this.mobileNumber,
      this.iV,
      this.createdAt,
      this.isVerified,
      this.otp,
      this.profileImage,
      this.role,
      this.wallet});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobileNumber = json['mobileNumber'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    isVerified = json['isVerified'];
    otp = json['otp'];
    profileImage = json['profileImage'];
    role = json['role'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mobileNumber'] = mobileNumber;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['isVerified'] = isVerified;
    data['otp'] = otp;
    data['profileImage'] = profileImage;
    data['role'] = role;
    data['wallet'] = wallet;
    return data;
  }
}
