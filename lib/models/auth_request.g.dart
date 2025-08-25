// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestOtpRequest _$RequestOtpRequestFromJson(Map<String, dynamic> json) =>
    RequestOtpRequest(phoneNumber: json['phone_number'] as String);

Map<String, dynamic> _$RequestOtpRequestToJson(RequestOtpRequest instance) =>
    <String, dynamic>{'phone_number': instance.phoneNumber};

VerifyOtpRequest _$VerifyOtpRequestFromJson(Map<String, dynamic> json) =>
    VerifyOtpRequest(
      phoneNumber: json['phone_number'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$VerifyOtpRequestToJson(VerifyOtpRequest instance) =>
    <String, dynamic>{
      'phone_number': instance.phoneNumber,
      'otp': instance.otp,
    };

CompleteRegistrationRequest _$CompleteRegistrationRequestFromJson(
  Map<String, dynamic> json,
) => CompleteRegistrationRequest(
  fullName: json['full_name'] as String,
  email: json['email'] as String,
);

Map<String, dynamic> _$CompleteRegistrationRequestToJson(
  CompleteRegistrationRequest instance,
) => <String, dynamic>{'full_name': instance.fullName, 'email': instance.email};

LoginRequest _$LoginRequestFromJson(Map<String, dynamic> json) =>
    LoginRequest(phoneNumber: json['phone_number'] as String);

Map<String, dynamic> _$LoginRequestToJson(LoginRequest instance) =>
    <String, dynamic>{'phone_number': instance.phoneNumber};
