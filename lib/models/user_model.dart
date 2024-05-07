class SaknyUserModel {
  String name;
  String? email;
  String phone;
  String? nationalId;
  String? gender;
  String? birthDate;
  String? uId;
  String? image;
  String bio;
  String? type;
  bool? isEmailVerified;

  SaknyUserModel({
    this.email,
    required this.name,
    required this.phone,
    this.nationalId,
    required this.bio,
    this.gender,
    this.uId,
    this.birthDate,
    this.type,
    this.image,
    this.isEmailVerified,
  });

  factory SaknyUserModel.fromJson(Map<String, dynamic>? json) {
    return SaknyUserModel(
      email: json?['email'] ?? '',
      name: json?['name'] ?? '',
      phone: json?['phone'] ?? '',
      nationalId: json?['nationalId'] ?? '',
      gender: json?['gender'] ?? '',
      uId: json?['uId'] ?? '',
      birthDate: json?['birthDate'] ?? '',
      type: json?['type'] ?? '',
      bio: json?['bio'] ?? '',
      image: json?['image'] ?? '',
      isEmailVerified: json?['isEmailVerified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'bio': bio,
      'name': name,
      'phone': phone,
      'nationalId': nationalId,
      'gender': gender,
      'uId': uId,
      'birthDate': birthDate,
      'type': type,
      'image': image,
      'isEmailVerified': isEmailVerified,
    };
  }
}
