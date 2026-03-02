import 'package:json_annotation/json_annotation.dart';

part 'created_order_model.g.dart';

@JsonSerializable()
class CreatedOrderModel {
  @JsonKey(name: "order_id")
  final int orderId;
  CreatedOrderModel(this.orderId);

  factory CreatedOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CreatedOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedOrderModelToJson(this);
}
