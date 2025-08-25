import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080';
  late final Dio _dio;
  late final ApiClient _apiClient;

  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    _setupInterceptors();
    _apiClient = ApiClient(_dio);
  }

  void _setupInterceptors() {
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

    // Add logging interceptor for debugging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (object) => print(object),
      ),
    );
  }

  // Request OTP
  Future<ApiResponse<dynamic>> requestOtp(String phoneNumber) async {
    try {
      final request = RequestOtpRequest(phoneNumber: phoneNumber);
      return await _apiClient.requestOtp(request);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Verify OTP
  Future<ApiResponse<dynamic>> verifyOtp(String phoneNumber, String otp) async {
    try {
      final request = VerifyOtpRequest(phoneNumber: phoneNumber, otp: otp);
      final response = await _apiClient.verifyOtp(request);

      // Save token if verification is successful
      if (response.success && response.token != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', response.token!);
      }

      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Complete Registration
  Future<ApiResponse<dynamic>> completeRegistration(
    String fullName,
    String email,
  ) async {
    try {
      final request = CompleteRegistrationRequest(
        fullName: fullName,
        email: email,
      );
      return await _apiClient.completeRegistration(request);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Login
  Future<ApiResponse<dynamic>> login(String phoneNumber) async {
    try {
      final request = LoginRequest(phoneNumber: phoneNumber);
      return await _apiClient.login(request);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  // Get current token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Check if user is authenticated
  Future<bool> isAuthenticated() async {
    final token = await getToken();
    return token != null;
  }

  // Helper method to handle errors
  String _handleError(DioException e) {
    if (e.response != null) {
      final data = e.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        return data['message'];
      }
      return 'An error occurred: ${e.response?.statusCode}';
    } else {
      return e.message ?? 'Network error occurred';
    }
  }
}
