import '../repositories/auth_repository.dart';

class RequestOtp {
  final AuthRepository repository;
  RequestOtp(this.repository);

  Future<void> call(String phoneNumber) {
    return repository.requestOtp(phoneNumber);
  }
}