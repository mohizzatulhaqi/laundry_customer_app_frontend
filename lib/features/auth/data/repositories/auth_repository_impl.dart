// lib/features/auth/data/repositories/auth_repository_impl.dart
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/api_services.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;
  AuthRepositoryImpl(this.apiService);

  @override
  Future<void> requestOtp(String phoneNumber) {
    return apiService.requestOtp(phoneNumber);
  }

  @override
  Future<void> verifyOtp(String phoneNumber, String otp) {
    return apiService.verifyOtp(phoneNumber, otp);
  }

  @override
  Future<User> completeRegistration(String fullName, String email) async {
    final response = await apiService.completeRegistration(fullName, email);
    final data = response.data;

    return User(
      id: data['id'],
      fullName: data['full_name'],
      email: data['email'],
      phoneNumber: data['phone_number'],
    );
  }

  @override
  Future<User> login(String phoneNumber, String otp) async {
    final response = await apiService.login(phoneNumber, otp);
    final data = response.data;

    return User(
      id: data['id'],
      fullName: data['full_name'],
      email: data['email'],
      phoneNumber: data['phone_number'],
    );
  }

  @override
  Future<void> logout() => apiService.logout();

  @override
  Future<bool> isAuthenticated() => apiService.isAuthenticated();
}
