import 'package:fake_store/core/network/shared.dart';
import 'package:fake_store/features/home/data/data_source/home_remote_data_source.dart';
import 'package:fake_store/features/home/data/repositories/category_repository_impl.dart';
import 'package:fake_store/features/home/data/repositories/products_repository_impl.dart';
import 'package:fake_store/features/home/domain/repositories/category_repository.dart';
import 'package:fake_store/features/home/domain/repositories/product_repository.dart';
import 'package:fake_store/features/home/domain/usecases/category_usecase.dart';
import 'package:fake_store/features/home/domain/usecases/product_usecase.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
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
  sl.registerLazySingleton(() => DioHelper.dioInstance);
  // Secure Storage
  sl.registerLazySingleton(() => SecureStorageService());

  // Repositories
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // UseCases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));

  // Cubits

  // Use cases
  sl.registerLazySingleton(() => CategoryUsecase(sl()));
  sl.registerLazySingleton(() => ProductUsecase(sl()));

  // Repository
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(),
  );
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(sl<HomeRemoteDataSource>()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductsRepositoryImpl(sl<HomeRemoteDataSource>()),
  );

  sl.registerFactory(
    () => AuthCubit(sl<LoginUseCase>(), sl<SecureStorageService>()),
  );

  // // Products
  // sl.registerLazySingleton<ProductRemoteDataSource>(
  //   () => ProductRemoteDataSourceImpl(sl<Dio>()),
  // );
  // sl.registerLazySingleton<ProductRepository>(
  //   () => ProductRepositoryImpl(sl()),
  // );
  // sl.registerLazySingleton(() => FetchProductsUseCase(sl()));
  sl.registerFactory(
    () => HomeCubit(
      categoryUsecase: sl(),
      secureStorageService: sl(),
      productUsecase: sl(),
    ),
  );
}
