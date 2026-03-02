import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel {
  final int id;

  final OrderStatus status;
  @JsonKey(name: "total_price")
  final String totalPrice;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "product_image")
  final String productImage;

  OrderModel(
    this.id,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.productImage,
  );

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$OrderModelToJson(this);
}

enum OrderStatus {
  @JsonValue('confirmed')
  confirmed,

  @JsonValue('rejected')
  rejected,

  @JsonValue('pending')
  pending,
}
