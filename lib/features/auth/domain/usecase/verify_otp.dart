import '../repositories/auth_repository.dart';

class VerifyOtp {
  final AuthRepository repository;
  VerifyOtp(this.repository);

  Future<void> call(String phoneNumber, String otp) {
    return repository.verifyOtp(phoneNumber, otp);
  }
}
