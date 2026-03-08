import 'package:json_annotation/json_annotation.dart';
part 'topping_model.g.dart';

@JsonSerializable()
class ToppingModel {
  final int id;
  final String name;

  @JsonKey(name: 'image')
  final String imageUrl;
  ToppingModel({required this.id, required this.name, required this.imageUrl});

  factory ToppingModel.fromJson(Map<String, dynamic> json) =>
      _$ToppingModelFromJson(json);

  Map<String, dynamic> toJson() => _$ToppingModelToJson(this);
}
