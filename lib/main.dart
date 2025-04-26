import 'package:fake_store/core/shared/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'core/di/di.dart' as di;
import 'features/auth/presentation/screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Demo',
      home: LoginScreen(),
      navigatorKey: AppConstants.navigatorKey,
    );
  }
}
