import 'package:json_annotation/json_annotation.dart';

part 'auth_response.g.dart';

@JsonSerializable()
class ApiResponse<T> {
  final bool success;
  final String? message;
  final dynamic data;
  final String? token;

  ApiResponse({required this.success, this.message, this.data, this.token});

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$ApiResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ApiResponseToJson(this);
}
