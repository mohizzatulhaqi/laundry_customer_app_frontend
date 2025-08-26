import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_client.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

class ApiService {
  final Dio _dio;
  final ApiClient _apiClient;

  ApiService(String baseUrl)
    : _dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          headers: {'Content-Type': 'application/json'},
        ),
      ),
      _apiClient = ApiClient(
        Dio(BaseOptions(baseUrl: baseUrl)),
        baseUrl: baseUrl,
      ) {
    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final prefs = await SharedPreferences.getInstance();
          final token = prefs.getString('token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.remove('token');
          }
          return handler.next(e);
        },
      ),
    );

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

  // Login with OTP
  Future<ApiResponse<dynamic>> login(
    String phoneNumber,
    String otp,
  ) async {
    try {
      // First verify the OTP
      final verifyResponse = await verifyOtp(phoneNumber, otp);
      
      if (verifyResponse.success) {
        // If OTP is valid, proceed with login
        final request = LoginRequest(phoneNumber: phoneNumber);
        final loginResponse = await _apiClient.login(request);
        
        // Save token if login is successful
        if (loginResponse.success && loginResponse.token != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('token', loginResponse.token!);
        }
        
        return loginResponse;
      } else {
        return verifyResponse;
      }
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
