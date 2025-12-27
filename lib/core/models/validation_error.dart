import 'package:json_annotation/json_annotation.dart';

part 'validation_error.g.dart';

@JsonSerializable()
class ValidationResponse {
  final String? type;
  @JsonKey(name: 'title')
  final String? titleValue;
  @JsonKey(name: 'message')
  final String? messageValue;
  @JsonKey(defaultValue: {})
  final Map<String, List<dynamic>> errors;

  const ValidationResponse({
    required this.type,
    required this.titleValue,
    required this.messageValue,
    required this.errors,
  });

  String? get message => titleValue ?? messageValue;

  factory ValidationResponse.fromJson(Map<String, dynamic> json) =>
      _$ValidationResponseFromJson(json);
}
