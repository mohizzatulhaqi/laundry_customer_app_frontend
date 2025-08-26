import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class RequestOtpEvent extends AuthEvent {
  final String phoneNumber;

  const RequestOtpEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const VerifyOtpEvent({required this.phoneNumber, required this.otp});

  @override
  List<Object?> get props => [phoneNumber, otp];
}

class CompleteRegistrationEvent extends AuthEvent {
  final String fullName;
  final String email;

  const CompleteRegistrationEvent({
    required this.fullName,
    required this.email,
  });

  @override
  List<Object?> get props => [fullName, email];
}

class LoginEvent extends AuthEvent {
  final String phoneNumber;
  final String otp;

  const LoginEvent({required this.phoneNumber, required this.otp});

  @override
  List<Object?> get props => [phoneNumber, otp];
}

class LogoutEvent extends AuthEvent {
  const LogoutEvent();
}

class CheckAuthenticationEvent extends AuthEvent {
  const CheckAuthenticationEvent();
}
