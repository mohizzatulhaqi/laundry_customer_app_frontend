import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/error/failures.dart';
import 'package:laundry_customer_app/core/usecases/usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/repositories/auth_repository.dart';

class IsAuthenticated implements UseCase<bool, NoParams> {
  final AuthRepository repository;

  IsAuthenticated(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isAuthenticated();
  }
}
