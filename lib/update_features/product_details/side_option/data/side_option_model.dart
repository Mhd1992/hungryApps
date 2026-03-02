import 'package:json_annotation/json_annotation.dart';
part 'side_option_model.g.dart';

@JsonSerializable()
class SideOptionModel {
  final int id;
  final String name;

  @JsonKey(name: 'image')
  final String imageUrl;
  SideOptionModel({
    required this.id,
    required this.name,
    required this.imageUrl,
  });

  factory SideOptionModel.fromJson(Map<String, dynamic> json) =>
      _$SideOptionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SideOptionModelToJson(this);
}
