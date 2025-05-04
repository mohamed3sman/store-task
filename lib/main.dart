import 'package:fake_store/core/config/app_routes.dart';
import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:fake_store/core/shared/constants/cach_helper.dart';
import 'package:fake_store/core/shared/constants/theme_cubit.dart';
import 'package:fake_store/features/favourites/presentation/cubit/favourites_cubit.dart';
import 'package:fake_store/features/home/domain/entities/product_entity.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await Hive.initFlutter();
  Hive.registerAdapter(ProductEntityAdapter());
  await CacheHelper().init();
  await Hive.openBox<ProductEntity>(AppConstants.favorites);
  await Hive.openBox<ProductEntity>(AppConstants.cachedProducts);
  // if internet id here
  // Hive.box<ProductEntity>(AppConstants.cachedProducts).clear();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<FavouritesCubit>()),
        BlocProvider(create: (_) => di.sl<HomeCubit>()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeCubit();
    themeCubit.initTheme();
    return BlocProvider.value(
      value: themeCubit,
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: state,
            routerConfig: router,
          );
        },
      ),
    );
  }
}
