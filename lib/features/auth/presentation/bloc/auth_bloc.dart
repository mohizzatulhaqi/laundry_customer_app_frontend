import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:laundry_customer_app/core/usecases/usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/usecases/request_otp_usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/usecases/verify_otp_usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/usecases/complete_registration_usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/usecases/login_usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/usecases/logout_usecase.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RequestOtp requestOtpUseCase;
  final VerifyOtp verifyOtpUseCase;
  final CompleteRegistration completeRegistrationUseCase;
  final Login loginUseCase;
  final Logout logoutUseCase;

  AuthBloc({
    required this.requestOtpUseCase,
    required this.verifyOtpUseCase,
    required this.completeRegistrationUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
  }) : super(AuthInitial()) {
    on<RequestOtpEvent>(_onRequestOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<CompleteRegistrationEvent>(_onCompleteRegistration);
    on<LoginEvent>(_onLogin);
    on<LogoutEvent>(_onLogout);
  }

  FutureOr<void> _onRequestOtp(
    RequestOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await requestOtpUseCase.call(event.phoneNumber);
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(OtpRequest()),
    );
  }

  FutureOr<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await verifyOtpUseCase.call(
      VerifyOtpParams(phoneNumber: event.phoneNumber, otp: event.otp),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(OtpVerified()),
    );
  }

  FutureOr<void> _onCompleteRegistration(
    CompleteRegistrationEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final result = await completeRegistrationUseCase.call(
      CompleteRegistrationParams(fullName: event.fullName, email: event.email),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  FutureOr<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await loginUseCase.call(
      LoginParams(phoneNumber: event.phoneNumber, otp: event.otp),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  FutureOr<void> _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await logoutUseCase.call(NoParams());
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthInitial()),
    );
  }
}
