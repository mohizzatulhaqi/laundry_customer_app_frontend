import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      sendTimeout: const Duration(seconds: 30),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Get token from SharedPreferences
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');

          // Add token to header if exists
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          // Handle 401 Unauthorized
          if (e.response?.statusCode == 401) {
            // Clear token and redirect to login
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
            // You might want to add navigation to login screen here
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Request OTP
  Future<Map<String, dynamic>> requestOtp(String phoneNumber) async {
    try {
      final response = await _dio.post(
        '/auth/request-otp',
        data: {'phone_number': phoneNumber},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Verify OTP
  Future<Map<String, dynamic>> verifyOtp(String phoneNumber, String otp) async {
    try {
      final response = await _dio.post(
        '/auth/verify-otp',
        data: {'phone_number': phoneNumber, 'otp': otp},
      );

      // Save token if verification is successful
      if (response.data['success'] == true) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.data['token']);
      }

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Complete Registration
  Future<Map<String, dynamic>> completeRegistration(
    String fullName,
    String email,
  ) async {
    try {
      final response = await _dio.post(
        '/auth/complete-registration',
        data: {'full_name': fullName, 'email': email},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Login
  Future<Map<String, dynamic>> login(String phoneNumber) async {
    try {
      final response = await _dio.post(
        '/auth/login',
        data: {'phone_number': phoneNumber},
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Helper method to handle errors
  String _handleError(DioException e) {
    if (e.response != null) {
      return e.response?.data['message'] ?? 'An error occurred';
    } else {
      return e.message ?? 'Network error occurred';
    }
  }
}
