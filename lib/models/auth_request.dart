import 'package:json_annotation/json_annotation.dart';

part 'auth_request.g.dart';

@JsonSerializable()
class RequestOtpRequest {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  RequestOtpRequest({required this.phoneNumber});

  factory RequestOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$RequestOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$RequestOtpRequestToJson(this);
}

@JsonSerializable()
class VerifyOtpRequest {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;
  final String otp;

  VerifyOtpRequest({required this.phoneNumber, required this.otp});

  factory VerifyOtpRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyOtpRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyOtpRequestToJson(this);
}

@JsonSerializable()
class CompleteRegistrationRequest {
  @JsonKey(name: 'full_name')
  final String fullName;
  final String email;

  CompleteRegistrationRequest({required this.fullName, required this.email});

  factory CompleteRegistrationRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteRegistrationRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteRegistrationRequestToJson(this);
}

@JsonSerializable()
class LoginRequest {
  @JsonKey(name: 'phone_number')
  final String phoneNumber;

  LoginRequest({required this.phoneNumber});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}
