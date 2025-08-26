import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/error/failures.dart';
import 'package:laundry_customer_app/core/usecases/usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/entities/user_entity.dart';
import 'package:laundry_customer_app/features/auth/domain/repositories/auth_repository.dart';

class CompleteRegistration implements UseCase<UserEntity, CompleteRegistrationParams> {
  final AuthRepository repository;

  CompleteRegistration(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(CompleteRegistrationParams params) async {
    return await repository.completeRegistration(params.fullName, params.email);
  }
}

class CompleteRegistrationParams {
  final String fullName;
  final String email;

  CompleteRegistrationParams({required this.fullName, required this.email});
}
