import 'package:json_annotation/json_annotation.dart';
part 'order_history_model.g.dart';

@JsonSerializable()
class OrderHistory {
  final int id;
  @JsonKey(name: "total_price")
  final String totalPrice;
  final String status;
  @JsonKey(name: "created_at")
  final String createdAt;
  @JsonKey(name: "product_image")
  final String productImage;

  OrderHistory(
    this.id,
    this.totalPrice,
    this.status,
    this.createdAt,
    this.productImage,
  );

  factory OrderHistory.fromJson(Map<String, dynamic> json) =>
      _$OrderHistoryFromJson(json);

  Map<String, dynamic> toJson() => _$OrderHistoryToJson(this);
}
