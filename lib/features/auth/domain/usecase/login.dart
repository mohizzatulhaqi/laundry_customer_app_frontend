import '../repositories/auth_repository.dart';
import '../entities/user.dart';

class Login {
  final AuthRepository repository;
  Login(this.repository);

  Future<User> call(String phoneNumber, String password) {
    return repository.login(phoneNumber, password);
  }
}