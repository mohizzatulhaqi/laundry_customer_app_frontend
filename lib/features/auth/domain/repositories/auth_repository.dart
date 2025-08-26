import 'package:laundry_customer_app/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<void> requestOtp(String phoneNumber);
  Future<void> verifyOtp(String phoneNumber, String otp);
  Future<User> completeRegistration(String fullName, String email);
  Future<User> login(String phoneNumber, String password);
  Future<void> logout();
  Future<bool> isAuthenticated();
}