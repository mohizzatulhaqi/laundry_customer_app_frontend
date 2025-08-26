import 'package:equatable/equatable.dart';
import 'package:laundry_customer_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class OtpRequest extends AuthState {
  const OtpRequest();
}

class OtpVerified extends AuthState {
  const OtpVerified();
}

class RegistrationComplete extends AuthState {
  const RegistrationComplete();
}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}

class AuthChecked extends AuthState {
  final bool isAuthenticated;

  const AuthChecked({required this.isAuthenticated});

  @override
  List<Object?> get props => [isAuthenticated];
}
