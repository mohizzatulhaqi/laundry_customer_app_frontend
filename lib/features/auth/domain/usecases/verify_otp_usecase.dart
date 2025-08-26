import 'package:dartz/dartz.dart';
import 'package:laundry_customer_app/core/error/failures.dart';
import 'package:laundry_customer_app/core/usecases/usecase.dart';
import 'package:laundry_customer_app/features/auth/domain/repositories/auth_repository.dart';

class VerifyOtp implements UseCase<bool, VerifyOtpParams> {
  final AuthRepository repository;

  VerifyOtp(this.repository);

  @override
  Future<Either<Failure, bool>> call(VerifyOtpParams params) async {
    return await repository.verifyOtp(params.phoneNumber, params.otp);
  }
}

class VerifyOtpParams {
  final String phoneNumber;
  final String otp;

  VerifyOtpParams({required this.phoneNumber, required this.otp});
}
