import 'package:fake_store/core/shared/constants/cach_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme) {
    initTheme();
  }
  bool isLightTheme = true;
  static final ThemeData lightTheme = ThemeData(brightness: Brightness.light);
  static final ThemeData darkTheme = ThemeData(brightness: Brightness.dark);

  void toggleTheme() {
    isLightTheme = !isLightTheme;
    emit(state == lightTheme ? darkTheme : lightTheme);
    CacheHelper.saveSharedData(key: 'theme', value: isLightTheme);
    debugPrint('Theme changed to $isLightTheme');
  }

  /// Call this method after initializing CacheHelper
  Future<void> initTheme() async {
    isLightTheme = await CacheHelper.getSharedData(key: 'theme') ?? true;
    emit(isLightTheme == true ? lightTheme : darkTheme);
    debugPrint('Loaded theme: $isLightTheme');
  }
}
