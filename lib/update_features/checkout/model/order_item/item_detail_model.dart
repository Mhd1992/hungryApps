import 'package:json_annotation/json_annotation.dart';

import '../orders/order_model.dart';
import 'order_item_model.dart';

part 'item_detail_model.g.dart';

@JsonSerializable()
class ItemDetailModel {
  final int id;

  final OrderStatus status;
  @JsonKey(name: "total_price")
  final String totalPrice;
  @JsonKey(name: "created_at")
  final String createdAt;

  @JsonKey(name: "items")
  List<OrderItemModel> orderItems;

  ItemDetailModel(
    this.id,
    this.status,
    this.totalPrice,
    this.createdAt,
    this.orderItems,
  );

  factory ItemDetailModel.fromJson(Map<String, dynamic> json) =>
      _$ItemDetailModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemDetailModelToJson(this);
}
