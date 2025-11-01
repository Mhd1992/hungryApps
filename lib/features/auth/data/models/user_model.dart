class UserModel {
  final String name;
  final String email;
  final String? token;
  final String? image;
  final String? visa;
  final String? address;

  UserModel({
    required this.name,
    required this.email,
    this.token,
    this.image,
    this.visa,
    this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      token: json['token'],
      image: json['image'],
      visa: json['Visa'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'token': token,
      'image': image,
      'visa': visa,
      'address': address,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$name------$visa';
    return super.toString();
  }
}
