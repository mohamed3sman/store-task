import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:fake_store/features/home/presentation/cubit/home_cubit.dart';
import 'package:fake_store/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/di/di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => di.sl<HomeCubit>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      home: HomeScreen(),
      navigatorKey: AppConstants.navigatorKey,
    );
  }
}
