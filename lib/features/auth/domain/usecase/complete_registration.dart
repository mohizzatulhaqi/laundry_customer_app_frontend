import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class CompleteRegistration {
  final AuthRepository repository;
  CompleteRegistration(this.repository);

  Future<User> call(String fullName, String email) {
    return repository.completeRegistration(fullName, email);
  }
}