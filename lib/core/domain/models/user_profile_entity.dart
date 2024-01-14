class UserProfile {
  String? sId;
  String? mobileNumber;
  int? iV;
  String? createdAt;
  bool? isVerified;
  String? profileImage;
  String? role;
  int? wallet;
  String? address;
  String? email;
  String? name;
  String? uploadSelfie;

  UserProfile({
    this.sId,
    this.mobileNumber,
    this.iV,
    this.createdAt,
    this.isVerified,
    this.profileImage,
    this.role,
    this.wallet,
    this.address,
    this.email,
    this.name,
    this.uploadSelfie,
  });

  UserProfile.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    mobileNumber = json['mobileNumber'];
    iV = json['__v'];
    createdAt = json['createdAt'];
    isVerified = json['isVerified'];
    profileImage = json['profileImage'];
    role = json['role'];
    wallet = json['wallet'];
    address = json['address'];
    email = json['email'];
    name = json['name'];
    uploadSelfie = json['uploadSelfie'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['mobileNumber'] = mobileNumber;
    data['__v'] = iV;
    data['createdAt'] = createdAt;
    data['isVerified'] = isVerified;
    data['profileImage'] = profileImage;
    data['role'] = role;
    data['wallet'] = wallet;
    data['address'] = address;
    data['email'] = email;
    data['name'] = name;
    data['uploadSelfie'] = uploadSelfie;
    return data;
  }
}
