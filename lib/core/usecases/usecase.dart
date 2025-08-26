import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
