import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/error/failures.dart';
import 'package:laundry_customer_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, bool>> requestOtp(String phoneNumber);
  Future<Either<Failure, bool>> verifyOtp(String phoneNumber, String otp);
  Future<Either<Failure, UserEntity>> completeRegistration(String fullName, String email);
  Future<Either<Failure, UserEntity>> login(String phoneNumber, String otp);
  Future<Either<Failure, void>> logout();
  Future<Either<Failure, bool>> isAuthenticated();
}