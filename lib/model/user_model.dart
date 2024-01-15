class UserModel {
  late String? name;
  late String? email;
  late String? phone;
  late String? uId;
  late String? bio;
  late String? image;
  late String? coverImage;
  late bool? isEmailVerified;
  UserModel({
    this.name,
    this.email,
    this.phone,
    this.uId,
    this.bio,
    this.image,
    this.coverImage,
    this.isEmailVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    image = json['image'];
    bio = json['bio'];
    coverImage = json['coverImage'];
    isEmailVerified = json['isEmailVerified'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'bio': bio,
      'coverImage': coverImage,
      'isEmailVerified': isEmailVerified,
    };
  }
}
