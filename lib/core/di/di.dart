import 'package:fake_store/core/network/shared.dart';
import 'package:get_it/get_it.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../network/dio_helper.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  DioHelper.init();

  // Secure Storage
  sl.registerLazySingleton(() => SecureStorageService());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));

  // Cubits
  sl.registerFactory(
    () => AuthCubit(sl<LoginUseCase>(), sl<SecureStorageService>()),
  );
}
