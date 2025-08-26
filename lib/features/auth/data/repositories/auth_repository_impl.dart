import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../services/api_services.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;
  
  const AuthRepositoryImpl(this.apiService);

  @override
  Future<Either<Failure, bool>> requestOtp(String phoneNumber) async {
    try {
      final response = await apiService.requestOtp(phoneNumber);
      if (response.success) {
        return const Right(true);
      } else {
        return Left(ServerFailure(response.message ?? 'Failed to request OTP'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyOtp(String phoneNumber, String otp) async {
    try {
      final response = await apiService.verifyOtp(phoneNumber, otp);
      if (response.success && response.token != null) {
        return const Right(true);
      } else {
        return Left(ServerFailure(response.message ?? 'OTP verification failed'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> completeRegistration(
    String fullName, 
    String email,
  ) async {
    try {
      final response = await apiService.completeRegistration(fullName, email);
      
      if (response.success && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        
        final user = UserEntity(
          id: data['id']?.toString() ?? '',
          fullName: data['full_name']?.toString(),
          email: data['email']?.toString(),
          phoneNumber: data['phone_number']?.toString(),
          token: response.token,
        );
        return Right(user);
      } else {
        return Left(ServerFailure(response.message ?? 'Registration failed'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> login(
    String phoneNumber, 
    String otp,
  ) async {
    try {
      // Note: The current API expects a password, but we're using OTP
      // This might need to be updated based on actual API requirements
      final response = await apiService.login(phoneNumber, otp);
      
      if (response.success && response.data != null) {
        final data = response.data as Map<String, dynamic>;
        
        final user = UserEntity(
          id: data['id']?.toString() ?? '',
          fullName: data['full_name']?.toString(),
          email: data['email']?.toString(),
          phoneNumber: data['phone_number']?.toString(),
          token: response.token,
        );
        return Right(user);
      } else {
        return Left(ServerFailure(response.message ?? 'Login failed'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await apiService.logout();
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isAuthenticated() async {
    try {
      final isAuth = await apiService.isAuthenticated();
      return Right(isAuth);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
