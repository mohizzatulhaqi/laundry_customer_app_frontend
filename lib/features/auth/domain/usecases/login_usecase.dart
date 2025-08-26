import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/error/failures.dart';
import 'package:laundry_customer_app/core/usecases/usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/entities/user_entity.dart';
import 'package:laundry_customer_app/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCase<UserEntity, LoginParams> {
  final AuthRepository repository;

  Login(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(LoginParams params) async {
    return await repository.login(params.phoneNumber, params.otp);
  }
}

class LoginParams {
  final String phoneNumber;
  final String otp;

  LoginParams({required this.phoneNumber, required this.otp});
}
