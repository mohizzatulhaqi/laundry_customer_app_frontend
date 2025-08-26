import 'package:get_it/get_it.dart';
import 'package:laundry_customer_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:laundry_customer_app/features/auth/data/services/api_services.dart';
import 'package:laundry_customer_app/features/auth/domain/repositories/auth_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  const baseUrl = "http://localhost:8080";

  // register ApiService
  sl.registerLazySingleton<ApiService>(() => ApiService(baseUrl));

  // register repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl<ApiService>()),
  );
}
