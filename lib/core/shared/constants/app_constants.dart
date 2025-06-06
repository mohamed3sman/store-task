import 'package:fake_store/core/config/app_routes.dart';
import 'package:flutter/material.dart';

abstract class AppConstants {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static const String baseUrl = "https://api.escuelajs.co/api/v1";
  // static const String graphqlUrl = "https://api.escuelajs.co/graphql";
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const String favorites = 'favorites';
  static const String cachedProducts = 'cachedProducts';
  static BuildContext? get ctx =>
      router.routerDelegate.navigatorKey.currentContext;
}
