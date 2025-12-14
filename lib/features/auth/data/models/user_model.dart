import 'package:hungry/core/utils/exported_file.dart';

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

  Future<FormData> toFormData() async {
    final data = <String, dynamic>{
      'name': name,
      'email': email,
      'address': address,
    };

    if (visa != null && visa!.isNotEmpty) {
      data['Visa'] = visa;
    }

    // ✅ Image is optional — handled safely here
    if (image != null && image!.isNotEmpty) {
      data['image'] = await MultipartFile.fromFile(
        image!,
        filename: 'upload.jpg',
      );
    }

    return FormData.fromMap(data);
  }

  @override
  String toString() {
    // TODO: implement toString
    return '$name------$visa';
    return super.toString();
  }
}
