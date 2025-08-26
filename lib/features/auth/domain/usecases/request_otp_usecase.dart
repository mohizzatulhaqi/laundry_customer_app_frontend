import 'package:laundry_customer_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/usecases/usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/repositories/auth_repository.dart';

class RequestOtp implements UseCase<bool, String> {
  final AuthRepository repository;

  RequestOtp(this.repository);

  @override
  Future<Either<Failure, bool>> call(String phoneNumber) async {
    return await repository.requestOtp(phoneNumber);
  }
}
