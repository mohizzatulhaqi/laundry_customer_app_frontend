import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../models/auth_request.dart';
import '../models/auth_response.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @POST('/auth/request-otp')
  Future<ApiResponse<dynamic>> requestOtp(@Body() RequestOtpRequest request);

  @POST('/auth/verify-otp')
  Future<ApiResponse<dynamic>> verifyOtp(@Body() VerifyOtpRequest request);

  @POST('/auth/complete-registration')
  Future<ApiResponse<dynamic>> completeRegistration(
    @Body() CompleteRegistrationRequest request,
  );

  @POST('/auth/login')
  Future<ApiResponse<dynamic>> login(@Body() LoginRequest request);
}
